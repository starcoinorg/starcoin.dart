part of starcoin_types;

abstract class WriteSetPayload {

  void serialize(BinarySerializer serializer);

  static WriteSetPayload deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return WriteSetPayloadDirectItem.load(deserializer);
      case 1: return WriteSetPayloadScriptItem.load(deserializer);
      default: throw new Exception("Unknown variant index for WriteSetPayload: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WriteSetPayload lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      WriteSetPayload value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
}


class WriteSetPayloadDirectItem extends WriteSetPayload {
  ChangeSet value;

  WriteSetPayloadDirectItem(ChangeSet value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static WriteSetPayloadDirectItem load(BinaryDeserializer deserializer){
    var value = ChangeSet.deserialize(deserializer);
    return new WriteSetPayloadDirectItem(value);
  }

  @override
  bool operator ==(covariant WriteSetPayloadDirectItem other) {
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

class WriteSetPayloadScriptItem extends WriteSetPayload {
  AccountAddress execute_as;
  Script script;

  WriteSetPayloadScriptItem(AccountAddress execute_as, Script script) {
    assert (execute_as != null);
    assert (script != null);
    this.execute_as = execute_as;
    this.script = script;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    execute_as.serialize(serializer);
    script.serialize(serializer);
  }

  static WriteSetPayloadScriptItem load(BinaryDeserializer deserializer){
    var execute_as = AccountAddress.deserialize(deserializer);
    var script = Script.deserialize(deserializer);
    return new WriteSetPayloadScriptItem(execute_as,script);
  }

  @override
  bool operator ==(covariant WriteSetPayloadScriptItem other) {
    if (other == null) return false;

    if (  this.execute_as == other.execute_as  &&
      this.script == other.script  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.execute_as != null ? this.execute_as.hashCode : 0);
    value = 31 * value + (this.script != null ? this.script.hashCode : 0);
    return value;
  }
}
