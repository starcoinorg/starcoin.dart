part of starcoin_types;

class TravelRuleMetadataV0 {
  Optional<String> off_chain_reference_id;

  TravelRuleMetadataV0(Optional<String> off_chain_reference_id) {
    assert (off_chain_reference_id != null);
    this.off_chain_reference_id = off_chain_reference_id;
  }

  void serialize(BinarySerializer serializer){
    TraitHelpers.serialize_option_str(off_chain_reference_id, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TravelRuleMetadataV0 deserialize(BinaryDeserializer deserializer){
    var off_chain_reference_id = TraitHelpers.deserialize_option_str(deserializer);
    return new TravelRuleMetadataV0(off_chain_reference_id);
  }

  static TravelRuleMetadataV0 bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      TravelRuleMetadataV0 value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant TravelRuleMetadataV0 other) {
    if (other == null) return false;

    if (  this.off_chain_reference_id == other.off_chain_reference_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.off_chain_reference_id != null ? this.off_chain_reference_id.hashCode : 0);
    return value;
  }

  TravelRuleMetadataV0.fromJson(dynamic json) :
    off_chain_reference_id = json['off_chain_reference_id'] ;

  dynamic toJson() => {
    "off_chain_reference_id" : off_chain_reference_id.isEmpty?null:off_chain_reference_id.value ,
  };
}
