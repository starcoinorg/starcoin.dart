part of starcoin_types;

class Module {
  Bytes code;

  Module(Bytes code) {
    assert (code != null);
    this.code = code;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_bytes(code);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Module deserialize(BinaryDeserializer deserializer){
    var code = deserializer.deserialize_bytes();
    return new Module(code);
  }

  static Module lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      Module value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant Module other) {
    if (other == null) return false;

    if (  this.code == other.code  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.code != null ? this.code.hashCode : 0);
    return value;
  }
}
