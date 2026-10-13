use rand::{CryptoRng, RngCore};
use zeroize::Zeroizing;

use super::error;
use super::Algorithm;
use super::Signature;

pub trait Verify {
    fn verify_signature(
        &self,
        data: &[u8],
        signature: &Signature,
    ) -> Result<(), error::CryptoError>;
    fn algorithm(&self) -> Algorithm;
}

pub trait Sign {
    type PublicKey: Verify;

    fn sign(&self, data: &[u8]) -> Result<Signature, error::CryptoError>;
    fn public(&self) -> Self::PublicKey;
    fn algorithm(&self) -> Algorithm;
}

pub trait SerializePublicKey: Verify + Clone + PartialEq + Sized {
    fn from_bytes_and_algorithm(
        algorithm: Algorithm,
        bytes: &[u8],
    ) -> Result<Self, error::CryptoError>;
    fn to_bytes(&self) -> Vec<u8>;
}

pub trait SerializePrivateKey: Sign<PublicKey: SerializePublicKey> + Clone + Sized {
    fn new_with_rng<R: RngCore + CryptoRng>(algorithm: Algorithm, rng: &mut R) -> Self;
    fn from_bytes_and_algorithm(
        algorithm: Algorithm,
        bytes: &[u8],
    ) -> Result<Self, error::CryptoError>;
    fn to_bytes(&self) -> Zeroizing<Vec<u8>>;
}
