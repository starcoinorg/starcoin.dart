part of starcoin_types;

abstract class Metadata {
  Metadata();

  void serialize(BinarySerializer serializer);

  static Metadata deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return MetadataUndefinedItem.load(deserializer);
      case 1: return MetadataGeneralMetadataItem.load(deserializer);
      case 2: return MetadataTravelRuleMetadataItem.load(deserializer);
      case 3: return MetadataUnstructuredBytesMetadataItem.load(deserializer);
      default: throw new Exception("Unknown variant index for Metadata: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Metadata bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      Metadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static Metadata fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return MetadataUndefinedItem.loadJson(json);
      case 1: return MetadataGeneralMetadataItem.loadJson(json);
      case 2: return MetadataTravelRuleMetadataItem.loadJson(json);
      case 3: return MetadataUnstructuredBytesMetadataItem.loadJson(json);
      default: throw new Exception("Unknown type for Metadata: " + type.toString());
    }
  }

  dynamic toJson();
}


class MetadataUndefinedItem extends Metadata {
  MetadataUndefinedItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
  }

  static MetadataUndefinedItem load(BinaryDeserializer deserializer){
    return new MetadataUndefinedItem();
  }

  @override
  bool operator ==(covariant MetadataUndefinedItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  MetadataUndefinedItem.loadJson(dynamic json);

  dynamic toJson() => {
    "type" : 0,
    "type_name" : "Undefined"
  };
}

class MetadataGeneralMetadataItem extends Metadata {
  GeneralMetadata value;

  MetadataGeneralMetadataItem(GeneralMetadata value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    value.serialize(serializer);
  }

  static MetadataGeneralMetadataItem load(BinaryDeserializer deserializer){
    var value = GeneralMetadata.deserialize(deserializer);
    return new MetadataGeneralMetadataItem(value);
  }

  @override
  bool operator ==(covariant MetadataGeneralMetadataItem other) {
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

  MetadataGeneralMetadataItem.loadJson(dynamic json) :
    value = GeneralMetadata.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 1,
    "type_name" : "GeneralMetadata"
  };
}

class MetadataTravelRuleMetadataItem extends Metadata {
  TravelRuleMetadata value;

  MetadataTravelRuleMetadataItem(TravelRuleMetadata value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(2);
    value.serialize(serializer);
  }

  static MetadataTravelRuleMetadataItem load(BinaryDeserializer deserializer){
    var value = TravelRuleMetadata.deserialize(deserializer);
    return new MetadataTravelRuleMetadataItem(value);
  }

  @override
  bool operator ==(covariant MetadataTravelRuleMetadataItem other) {
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

  MetadataTravelRuleMetadataItem.loadJson(dynamic json) :
    value = TravelRuleMetadata.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 2,
    "type_name" : "TravelRuleMetadata"
  };
}

class MetadataUnstructuredBytesMetadataItem extends Metadata {
  UnstructuredBytesMetadata value;

  MetadataUnstructuredBytesMetadataItem(UnstructuredBytesMetadata value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(3);
    value.serialize(serializer);
  }

  static MetadataUnstructuredBytesMetadataItem load(BinaryDeserializer deserializer){
    var value = UnstructuredBytesMetadata.deserialize(deserializer);
    return new MetadataUnstructuredBytesMetadataItem(value);
  }

  @override
  bool operator ==(covariant MetadataUnstructuredBytesMetadataItem other) {
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

  MetadataUnstructuredBytesMetadataItem.loadJson(dynamic json) :
    value = UnstructuredBytesMetadata.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 3,
    "type_name" : "UnstructuredBytesMetadata"
  };
}
