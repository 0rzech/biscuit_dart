// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder boilerplateBuilder(BuilderOptions options) =>
    PartBuilder([const BoilerplateGenerator()], '.bp.dart', options: options);

final class const BoilerplateGenerator()
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
    final equalityFields = getAllFields(element);

    final buffer = StringBuffer(
      'extension \$${className}Extension on $className {',
    );

    if (annotation.read('equality').boolValue) {
      var mustImportCollection = false;

      final checks = equalityFields
          .map((f) {
            final type = f.type;
            if (_isList(type)) {
              mustImportCollection = true;
              return 'const ListEquality().equals(${f.name}, other.${f.name})';
            } else if (_isMap(type)) {
              mustImportCollection = true;
              return 'const MapEquality().equals(${f.name}, other.${f.name})';
            } else if (_isSet(type)) {
              mustImportCollection = true;
              return 'const SetEquality().equals(${f.name}, other.${f.name})';
            } else {
              return '${f.name} == other.${f.name}';
            }
          })
          .join(' &&\n');

      if (mustImportCollection &&
          !element.library.fragments.first.libraryImports.any((li) {
            return li.importedLibrary?.uri.toString() ==
                'package:collection/collection.dart';
          })) {
        throw InvalidGenerationSourceError(
          "Missing import 'package:collection/collection.dart';.",
        );
      }

      if (checks.isNotEmpty) {
        buffer.writeln('\nbool _equals(Object other) =>');
        buffer.writeln('identical(this, other) ||');
        buffer.writeln('other is $className');

        if (annotation.read('runtimeTypeEquality').boolValue) {
          buffer.writeln('&& runtimeType == other.runtimeType');
        }

        if (checks.isNotEmpty) {
          buffer.writeln('&&');
          buffer.write(checks);
        }

        buffer.writeln(';\n\n');
      }

      final hashFields = equalityFields
          .map((f) {
            final type = f.type;
            if (_isList(type)) {
              return 'const ListEquality().hash(${f.name})';
            } else if (_isMap(type)) {
              return 'const MapEquality().hash(${f.name})';
            } else if (_isSet(type)) {
              return 'const SetEquality().hash(${f.name})';
            } else {
              return '${f.name}';
            }
          })
          .join(',\n');

      if (hashFields.isNotEmpty) {
        buffer.writeln('int get _hashCode => Object.hash(');
        buffer.writeln("'$className',");
        buffer.writeln(hashFields);
        buffer.writeln(');');
      }
    }

    if (annotation.read('string').boolValue) {
      buffer.writeln('\nString _toString() =>');
      buffer.write("'$className(");

      final toStringFields = equalityFields
          .map((f) => '${f.name}: \$${f.name}')
          .join(', ');

      buffer.write(toStringFields);
      buffer.writeln(")';");
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  List<FieldElement> getAllFields(ClassElement element) {
    final fields = <FieldElement>[];

    for (final type in element.allSupertypes.reversed.where((t) {
      return !t.isDartCoreObject;
    })) {
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

  bool _isList(DartType type) =>
      type.isDartCoreList ||
      type is InterfaceType && type.allSupertypes.any((t) => t.isDartCoreList);

  bool _isSet(DartType type) =>
      type.isDartCoreSet ||
      type is InterfaceType && type.allSupertypes.any((t) => t.isDartCoreSet);

  bool _isMap(DartType type) =>
      type.isDartCoreMap ||
      type is InterfaceType && type.allSupertypes.any((t) => t.isDartCoreMap);
}
