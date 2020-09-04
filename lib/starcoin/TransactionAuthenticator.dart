part of starcoin_types;

abstract class TransactionAuthenticator {

  void serialize(BinarySerializer serializer);

  static TransactionAuthenticator deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionAuthenticatorEd25519Item.load(deserializer);
      case 1: return TransactionAuthenticatorMultiEd25519Item.load(deserializer);
      default: throw new Exception("Unknown variant index for TransactionAuthenticator: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TransactionAuthenticator lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      TransactionAuthenticator value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
}


class TransactionAuthenticatorEd25519Item extends TransactionAuthenticator {
  Ed25519PublicKey public_key;
  Ed25519Signature signature;

  TransactionAuthenticatorEd25519Item(Ed25519PublicKey public_key, Ed25519Signature signature) {
    assert (public_key != null);
    assert (signature != null);
    this.public_key = public_key;
    this.signature = signature;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    public_key.serialize(serializer);
    signature.serialize(serializer);
  }

  static TransactionAuthenticatorEd25519Item load(BinaryDeserializer deserializer){
    var public_key = Ed25519PublicKey.deserialize(deserializer);
    var signature = Ed25519Signature.deserialize(deserializer);
    return new TransactionAuthenticatorEd25519Item(public_key,signature);
  }

  @override
  bool operator ==(covariant TransactionAuthenticatorEd25519Item other) {
    if (other == null) return false;

    if (  this.public_key == other.public_key  &&
      this.signature == other.signature  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.public_key != null ? this.public_key.hashCode : 0);
    value = 31 * value + (this.signature != null ? this.signature.hashCode : 0);
    return value;
  }
}

class TransactionAuthenticatorMultiEd25519Item extends TransactionAuthenticator {
  MultiEd25519PublicKey public_key;
  MultiEd25519Signature signature;

  TransactionAuthenticatorMultiEd25519Item(MultiEd25519PublicKey public_key, MultiEd25519Signature signature) {
    assert (public_key != null);
    assert (signature != null);
    this.public_key = public_key;
    this.signature = signature;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    public_key.serialize(serializer);
    signature.serialize(serializer);
  }

  static TransactionAuthenticatorMultiEd25519Item load(BinaryDeserializer deserializer){
    var public_key = MultiEd25519PublicKey.deserialize(deserializer);
    var signature = MultiEd25519Signature.deserialize(deserializer);
    return new TransactionAuthenticatorMultiEd25519Item(public_key,signature);
  }

  @override
  bool operator ==(covariant TransactionAuthenticatorMultiEd25519Item other) {
    if (other == null) return false;

    if (  this.public_key == other.public_key  &&
      this.signature == other.signature  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.public_key != null ? this.public_key.hashCode : 0);
    value = 31 * value + (this.signature != null ? this.signature.hashCode : 0);
    return value;
  }
}
