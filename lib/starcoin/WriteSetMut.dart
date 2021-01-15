part of starcoin_types;

class WriteSetMut {
  List<Tuple2<AccessPath, WriteOp>> write_set;

  WriteSetMut(List<Tuple2<AccessPath, WriteOp>> write_set) {
    assert (write_set != null);
    this.write_set = write_set;
  }

  void serialize(BinarySerializer serializer){
    TraitHelpers.serialize_vector_tuple2_AccessPath_WriteOp(write_set, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WriteSetMut deserialize(BinaryDeserializer deserializer){
    var write_set = TraitHelpers.deserialize_vector_tuple2_AccessPath_WriteOp(deserializer);
    return new WriteSetMut(write_set);
  }

  static WriteSetMut bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      WriteSetMut value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant WriteSetMut other) {
    if (other == null) return false;

    if (  isListsEqual(this.write_set , other.write_set)  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.write_set != null ? this.write_set.hashCode : 0);
    return value;
  }

  WriteSetMut.fromJson(dynamic json) :
    write_set = json['write_set'] ;

  dynamic toJson() => {
    'write_set' : write_set,
  };
}
