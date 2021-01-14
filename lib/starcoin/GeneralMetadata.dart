part of starcoin_types;

abstract class GeneralMetadata {
  GeneralMetadata();

  void serialize(BinarySerializer serializer);

  static GeneralMetadata deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return GeneralMetadataGeneralMetadataVersion0Item.load(deserializer);
      default: throw new Exception("Unknown variant index for GeneralMetadata: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static GeneralMetadata bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      GeneralMetadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static GeneralMetadata fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return GeneralMetadataGeneralMetadataVersion0Item.loadJson(json);
      default: throw new Exception("Unknown type for GeneralMetadata: " + type.toString());
    }
  }

  dynamic toJson();
}


class GeneralMetadataGeneralMetadataVersion0Item extends GeneralMetadata {
  GeneralMetadataV0 value;

  GeneralMetadataGeneralMetadataVersion0Item(GeneralMetadataV0 value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static GeneralMetadataGeneralMetadataVersion0Item load(BinaryDeserializer deserializer){
    var value = GeneralMetadataV0.deserialize(deserializer);
    return new GeneralMetadataGeneralMetadataVersion0Item(value);
  }

  @override
  bool operator ==(covariant GeneralMetadataGeneralMetadataVersion0Item other) {
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

  GeneralMetadataGeneralMetadataVersion0Item.loadJson(dynamic json) :
    value = GeneralMetadataV0.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 0,
    "type_name" : "GeneralMetadataVersion0"
  };
}
