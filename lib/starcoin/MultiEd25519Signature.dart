part of starcoin_types;

class MultiEd25519Signature {
  Bytes value;

  MultiEd25519Signature(Bytes value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_bytes(value);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static MultiEd25519Signature deserialize(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_bytes();
    return new MultiEd25519Signature(value);
  }

  static MultiEd25519Signature lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      MultiEd25519Signature value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant MultiEd25519Signature other) {
    if (other == null) return false;

    if (  this.value == other.value  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.value != null ? this.value.hashCode : 0);
    return value;
  }

  MultiEd25519Signature.fromJson(Map<String, dynamic> json) :
    value = Bytes.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
  };
}
