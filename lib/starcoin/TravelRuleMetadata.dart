part of starcoin_types;

abstract class TravelRuleMetadata {
  TravelRuleMetadata();

  void serialize(BinarySerializer serializer);

  static TravelRuleMetadata deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TravelRuleMetadataTravelRuleMetadataVersion0Item.load(deserializer);
      default: throw new Exception("Unknown variant index for TravelRuleMetadata: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TravelRuleMetadata lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      TravelRuleMetadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static TravelRuleMetadata fromJson(Map<String, dynamic> json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TravelRuleMetadataTravelRuleMetadataVersion0Item.loadJson(json);
      default: throw new Exception("Unknown type for TravelRuleMetadata: " + type.toString());
    }
  }

  Map<String, dynamic> toJson();
}


class TravelRuleMetadataTravelRuleMetadataVersion0Item extends TravelRuleMetadata {
  TravelRuleMetadataV0 value;

  TravelRuleMetadataTravelRuleMetadataVersion0Item(TravelRuleMetadataV0 value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static TravelRuleMetadataTravelRuleMetadataVersion0Item load(BinaryDeserializer deserializer){
    var value = TravelRuleMetadataV0.deserialize(deserializer);
    return new TravelRuleMetadataTravelRuleMetadataVersion0Item(value);
  }

  @override
  bool operator ==(covariant TravelRuleMetadataTravelRuleMetadataVersion0Item other) {
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

  TravelRuleMetadataTravelRuleMetadataVersion0Item.loadJson(Map<String, dynamic> json) :
    value = TravelRuleMetadataV0.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 0,
    "type_name" : "TravelRuleMetadataVersion0"
  };
}
