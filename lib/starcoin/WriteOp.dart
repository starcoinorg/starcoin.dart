part of starcoin_types;

abstract class WriteOp {

  void serialize(BinarySerializer serializer);

  static WriteOp deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return WriteOpDeletionItem.load(deserializer);
      case 1: return WriteOpValueItem.load(deserializer);
      default: throw new Exception("Unknown variant index for WriteOp: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WriteOp lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      WriteOp value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
}


class WriteOpDeletionItem extends WriteOp {
  WriteOpDeletionItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
  }

  static WriteOpDeletionItem load(BinaryDeserializer deserializer){
    return new WriteOpDeletionItem();
  }

  @override
  bool operator ==(covariant WriteOpDeletionItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }
}

class WriteOpValueItem extends WriteOp {
  Bytes value;

  WriteOpValueItem(Bytes value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    serializer.serialize_bytes(value);
  }

  static WriteOpValueItem load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_bytes();
    return new WriteOpValueItem(value);
  }

  @override
  bool operator ==(covariant WriteOpValueItem other) {
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
}
