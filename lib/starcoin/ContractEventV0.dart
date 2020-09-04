part of starcoin_types;

class ContractEventV0 {
  EventKey key;
  int sequence_number;
  TypeTag type_tag;
  Bytes event_data;

  ContractEventV0(EventKey key, int sequence_number, TypeTag type_tag, Bytes event_data) {
    assert (key != null);
    assert (sequence_number != null);
    assert (type_tag != null);
    assert (event_data != null);
    this.key = key;
    this.sequence_number = sequence_number;
    this.type_tag = type_tag;
    this.event_data = event_data;
  }

  void serialize(BinarySerializer serializer){
    key.serialize(serializer);
    serializer.serialize_u64(sequence_number);
    type_tag.serialize(serializer);
    serializer.serialize_bytes(event_data);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static ContractEventV0 deserialize(BinaryDeserializer deserializer){
    var key = EventKey.deserialize(deserializer);
    var sequence_number = deserializer.deserialize_u64();
    var type_tag = TypeTag.deserialize(deserializer);
    var event_data = deserializer.deserialize_bytes();
    return new ContractEventV0(key,sequence_number,type_tag,event_data);
  }

  static ContractEventV0 lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      ContractEventV0 value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant ContractEventV0 other) {
    if (other == null) return false;

    if (  this.key == other.key  &&
      this.sequence_number == other.sequence_number  &&
      this.type_tag == other.type_tag  &&
      this.event_data == other.event_data  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.key != null ? this.key.hashCode : 0);
    value = 31 * value + (this.sequence_number != null ? this.sequence_number.hashCode : 0);
    value = 31 * value + (this.type_tag != null ? this.type_tag.hashCode : 0);
    value = 31 * value + (this.event_data != null ? this.event_data.hashCode : 0);
    return value;
  }
}
