part of starcoin_types;

class WriteSet {
  WriteSetMut value;

  WriteSet(WriteSetMut value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    value.serialize(serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WriteSet deserialize(BinaryDeserializer deserializer){
    var value = WriteSetMut.deserialize(deserializer);
    return new WriteSet(value);
  }

  static WriteSet bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      WriteSet value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant WriteSet other) {
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

  WriteSet.fromJson(dynamic json) :
    value = json ;

  dynamic toJson() => value;
}
