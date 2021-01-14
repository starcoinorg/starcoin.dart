part of starcoin_types;

abstract class WriteSetPayload {
  WriteSetPayload();

  void serialize(BinarySerializer serializer);

  static WriteSetPayload deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return WriteSetPayloadDirectItem.load(deserializer);
      case 1: return WriteSetPayloadScriptItem.load(deserializer);
      default: throw new Exception("Unknown variant index for WriteSetPayload: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WriteSetPayload bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      WriteSetPayload value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static WriteSetPayload fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return WriteSetPayloadDirectItem.loadJson(json);
      case 1: return WriteSetPayloadScriptItem.loadJson(json);
      default: throw new Exception("Unknown type for WriteSetPayload: " + type.toString());
    }
  }

  dynamic toJson();
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

  WriteSetPayloadDirectItem.loadJson(dynamic json) :
    value = ChangeSet.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 0,
    "type_name" : "Direct"
  };
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

  WriteSetPayloadScriptItem.loadJson(dynamic json) :
    execute_as = AccountAddress.fromJson(json['execute_as']) ,
    script = Script.fromJson(json['script']) ;

  dynamic toJson() => {
    "execute_as" : execute_as.toJson() ,
    "script" : script.toJson() ,
    "type" : 1,
    "type_name" : "Script"
  };
}
