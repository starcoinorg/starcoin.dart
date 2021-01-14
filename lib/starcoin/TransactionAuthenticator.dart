part of starcoin_types;

abstract class TransactionAuthenticator {
  TransactionAuthenticator();

  void serialize(BinarySerializer serializer);

  static TransactionAuthenticator deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionAuthenticatorEd25519Item.load(deserializer);
      case 1: return TransactionAuthenticatorMultiEd25519Item.load(deserializer);
      default: throw new Exception("Unknown variant index for TransactionAuthenticator: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TransactionAuthenticator bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      TransactionAuthenticator value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static TransactionAuthenticator fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TransactionAuthenticatorEd25519Item.loadJson(json);
      case 1: return TransactionAuthenticatorMultiEd25519Item.loadJson(json);
      default: throw new Exception("Unknown type for TransactionAuthenticator: " + type.toString());
    }
  }

  dynamic toJson();
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

  TransactionAuthenticatorEd25519Item.loadJson(dynamic json) :
    public_key = Ed25519PublicKey.fromJson(json['public_key']) ,
    signature = Ed25519Signature.fromJson(json['signature']) ;

  dynamic toJson() => {
    "public_key" : public_key.toJson() ,
    "signature" : signature.toJson() ,
    "type" : 0,
    "type_name" : "Ed25519"
  };
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

  TransactionAuthenticatorMultiEd25519Item.loadJson(dynamic json) :
    public_key = MultiEd25519PublicKey.fromJson(json['public_key']) ,
    signature = MultiEd25519Signature.fromJson(json['signature']) ;

  dynamic toJson() => {
    "public_key" : public_key.toJson() ,
    "signature" : signature.toJson() ,
    "type" : 1,
    "type_name" : "MultiEd25519"
  };
}
