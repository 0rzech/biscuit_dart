// Copyright (c) 2019 Geoffroy Couprie <contact@geoffroycouprie.com> and Contributors to the Eclipse Foundation.
// SPDX-License-Identifier: Apache-2.0

//! signature algorithms
//!
//! The enum discriminants match the wire format numbering of public key
//! algorithms, so they can be cast to `i32` when building signature payloads.
use core::fmt::Display;

/// the algorithm used for signature generation
#[derive(Debug, Copy, Clone, PartialEq, Hash, Eq)]
pub enum Algorithm {
    Ed25519,
    Secp256r1,
}

impl Algorithm {
    pub fn values() -> &'static [Self] {
        &[Self::Ed25519, Self::Secp256r1]
    }
}

#[allow(clippy::derivable_impls)]
impl Default for Algorithm {
    fn default() -> Self {
        Self::Ed25519
    }
}

impl Display for Algorithm {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Algorithm::Ed25519 => write!(f, "ed25519"),
            Algorithm::Secp256r1 => write!(f, "secp256r1"),
        }
    }
}
