// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

Builder boilerplateBuilder(BuilderOptions options) {
  final emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);
  const genExt = '.bp.dart';
  return PartBuilder([BoilerplateGenerator(emitter)], genExt, options: options);
}

final class BoilerplateGenerator(final DartEmitter _emitter)
    extends
        // ignore: invalid_use_of_internal_member
        GeneratorForAnnotation<Boilerplate> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Boilerplate annotations can be applied only to classes',
        element: element,
      );
    }

    final className = element.name;
    final classFields = getAllFields(element);

    final extensionBuilder = ExtensionBuilder()
      ..name = '\$${className}Extension'
      ..on = refer(className!);

    if (annotation.read('equality').boolValue) {
      var mustImportCollection = false;

      final equalityFields = classFields.map((f) {
        final type = f.type;

        if (asList(type) case final type?) {
          mustImportCollection = true;
          return colEq('ListEquality', type, [f]);
        } else if (asMap(type) case final type?) {
          mustImportCollection = true;
          return colEq('MapEquality', type, [f]);
        } else if (asSet(type) case final type?) {
          mustImportCollection = true;
          return colEq('SetEquality', type, [f]);
        } else if (asUnmodifiableList(type) case (final type, final elem)?) {
          return colEq('ListEquality', type, [f, elem]);
        } else {
          return elemRef(f).equalTo(propChain([f], first: other));
        }
      });

      if (mustImportCollection &&
          !element.library.fragments.first.libraryImports.any((li) {
            return li.importedLibrary?.uri.toString() ==
                'package:collection/collection.dart';
          })) {
        throw InvalidGenerationSourceError(
          "Missing import 'package:collection/collection.dart';.",
        );
      }

      if (equalityFields.isNotEmpty) {
        final parameter = ParameterBuilder()
          ..name = 'other'
          ..type = refer('Object');

        final expressions = [
          refer('identical')
              .call([refer('this'), other])
              .or(other.isA(refer(className))),

          if (annotation.read('runtimeTypeEquality').boolValue)
            refer('runtimeType').equalTo(other.property('runtimeType')),

          ...equalityFields,
        ];

        final method = MethodBuilder()
          ..name = '_equals'
          ..returns = refer('bool')
          ..requiredParameters.add(parameter.build())
          ..lambda = true
          ..body = expressions.reduce((left, right) => left.and(right)).code;

        extensionBuilder.methods.add(method.build());
      }

      final hashFields = classFields.map((f) {
        final type = f.type;

        if (asList(type) case final type?) {
          return colHash('ListEquality', type, [f]);
        } else if (asMap(type) case final type?) {
          return colHash('MapEquality', type, [f]);
        } else if (asSet(type) case final type?) {
          return colHash('SetEquality', type, [f]);
        } else if (asUnmodifiableList(type) case (final type, final elem)?) {
          return colHash('ListEquality', type, [f, elem]);
        } else {
          return elemRef(f);
        }
      });

      if (hashFields.isNotEmpty) {
        final method = MethodBuilder()
          ..name = '_hashCode'
          ..returns = refer('int')
          ..type = .getter
          ..lambda = true
          ..body = refer('Object')
              .property('hash')
              .call([literalString(className), ...hashFields])
              .code;

        extensionBuilder.methods.add(method.build());
      }
    }

    if (annotation.read('string').boolValue) {
      final fields = classFields
          .map((f) => '${f.name}: \$${f.name}')
          .join(', ');

      final method = MethodBuilder()
        ..name = '_toString'
        ..returns = refer('String')
        ..lambda = true
        ..body = literalString('$className($fields)').code;

      extensionBuilder.methods.add(method.build());
    }

    return _emitter.visitExtension(extensionBuilder.build()).toString();
  }
}

List<FieldElement> getAllFields(ClassElement element) {
  final fields = <FieldElement>[];

  for (final type in element.allSupertypes.reversed.where(
    (t) => !t.isDartCoreObject,
  )) {
    fields.addAll(
      type.element.fields.where((f) {
        return !(f.isStatic || f.isOriginGetterSetter);
      }),
    );
  }

  fields.addAll(
    element.fields.where((f) {
      return !(f.isStatic || f.isOriginGetterSetter);
    }),
  );

  return fields;
}

InterfaceType? asList(DartType type) {
  if (type is! InterfaceType) return null;
  if (type.isDartCoreList) return type;
  return type.allSupertypes.firstWhereOrNull((t) => t.isDartCoreList);
}

InterfaceType? asSet(DartType type) {
  if (type is! InterfaceType) return null;
  if (type.isDartCoreSet) return type;
  return type.allSupertypes.firstWhereOrNull((t) => t.isDartCoreSet);
}

InterfaceType? asMap(DartType type) {
  if (type is! InterfaceType) return null;
  if (type.isDartCoreMap) return type;
  return type.allSupertypes.firstWhereOrNull((t) => t.isDartCoreMap);
}

(InterfaceType, Element)? asUnmodifiableList(DartType type) {
  if (type is! InterfaceType) return null;
  if (!unmodifiableListChecker.isExactlyType(type)) return null;

  final element = type.element;
  if (element is! ExtensionTypeElement) {
    throw InvalidGenerationSourceError(
      'Expecting UnmodifiableList to be an extension type',
      element: element,
    );
  }

  final name = element.representation.name;
  if (name == null) {
    throw InvalidGenerationSourceError(
      'Missing UnmodifiableList representation name',
      element: element,
    );
  }

  final getter = element.getGetter(name);
  if (getter == null) {
    throw InvalidGenerationSourceError(
      'Missing UnmodifiableList getter',
      element: element,
    );
  }

  return (type, getter);
}

Expression colEq(String className, InterfaceType type, List<Element> elements) {
  return TypeReference((builder) {
        builder.symbol = className;
        builder.types.addAll(type.typeArguments.map(toTypeRef));
      })
      .constInstance(const [])
      .property('equals')
      .call([propChain(elements), propChain(elements, first: other)]);
}

Expression colHash(
  String className,
  InterfaceType type,
  List<Element> elements,
) => TypeReference((builder) {
  builder.symbol = className;
  builder.types.addAll(type.typeArguments.map(toTypeRef));
}).constInstance(const []).property('hash').call([propChain(elements)]);

Expression propChain(List<Element> elements, {Reference? first}) {
  if (elements.isEmpty) throw ArgumentError('elements must not be empty');

  return first == null
      ? elements.skip(1).fold(elemRef(elements.first), prop)
      : elements.fold(first, prop);
}

Expression prop(Expression expression, Element element) =>
    expression.property(elemName(element));

Expression elemRef(Element element) => refer(elemName(element));

String elemName(Element element) {
  if (element.name case final name?) return name;

  throw InvalidGenerationSourceError(
    'Boilerplate cannot be generated for unnamed fields',
    element: element,
  );
}

TypeReference toTypeRef(DartType type) => TypeReference((builder) {
  builder.symbol = switch (type.element?.name) {
    null => type is DynamicType ? 'dynamic' : 'void',
    final name => name,
  };

  builder.isNullable = type.nullabilitySuffix == .question;

  builder.types.addAll(switch (type) {
    final InterfaceType t => t.typeArguments.map(toTypeRef),
    _ => const [],
  });
});

const unmodifiableListChecker = TypeChecker.fromUrl(
  'package:biscuit_auth/src/collection.dart#UnmodifiableList',
);

final other = refer('other');
