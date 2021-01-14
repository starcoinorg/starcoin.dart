part of starcoin_types;

abstract class DataPath {
  DataPath();

  void serialize(BinarySerializer serializer);

  static DataPath deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return DataPathCodeItem.load(deserializer);
      case 1: return DataPathResourceItem.load(deserializer);
      default: throw new Exception("Unknown variant index for DataPath: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static DataPath bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      DataPath value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static DataPath fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return DataPathCodeItem.loadJson(json);
      case 1: return DataPathResourceItem.loadJson(json);
      default: throw new Exception("Unknown type for DataPath: " + type.toString());
    }
  }

  dynamic toJson();
}


class DataPathCodeItem extends DataPath {
  Identifier value;

  DataPathCodeItem(Identifier value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static DataPathCodeItem load(BinaryDeserializer deserializer){
    var value = Identifier.deserialize(deserializer);
    return new DataPathCodeItem(value);
  }

  @override
  bool operator ==(covariant DataPathCodeItem other) {
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

  DataPathCodeItem.loadJson(dynamic json) :
    value = Identifier.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 0,
    "type_name" : "Code"
  };
}

class DataPathResourceItem extends DataPath {
  StructTag value;

  DataPathResourceItem(StructTag value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    value.serialize(serializer);
  }

  static DataPathResourceItem load(BinaryDeserializer deserializer){
    var value = StructTag.deserialize(deserializer);
    return new DataPathResourceItem(value);
  }

  @override
  bool operator ==(covariant DataPathResourceItem other) {
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

  DataPathResourceItem.loadJson(dynamic json) :
    value = StructTag.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 1,
    "type_name" : "Resource"
  };
}
