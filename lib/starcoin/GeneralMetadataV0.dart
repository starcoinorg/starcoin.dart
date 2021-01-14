part of starcoin_types;

class GeneralMetadataV0 {
  Optional<Bytes> to_subaddress;
  Optional<Bytes> from_subaddress;
  Optional<int> referenced_event;

  GeneralMetadataV0(Optional<Bytes> to_subaddress, Optional<Bytes> from_subaddress, Optional<int> referenced_event) {
    assert (to_subaddress != null);
    assert (from_subaddress != null);
    assert (referenced_event != null);
    this.to_subaddress = to_subaddress;
    this.from_subaddress = from_subaddress;
    this.referenced_event = referenced_event;
  }

  void serialize(BinarySerializer serializer){
    TraitHelpers.serialize_option_bytes(to_subaddress, serializer);
    TraitHelpers.serialize_option_bytes(from_subaddress, serializer);
    TraitHelpers.serialize_option_u64(referenced_event, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static GeneralMetadataV0 deserialize(BinaryDeserializer deserializer){
    var to_subaddress = TraitHelpers.deserialize_option_bytes(deserializer);
    var from_subaddress = TraitHelpers.deserialize_option_bytes(deserializer);
    var referenced_event = TraitHelpers.deserialize_option_u64(deserializer);
    return new GeneralMetadataV0(to_subaddress,from_subaddress,referenced_event);
  }

  static GeneralMetadataV0 bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      GeneralMetadataV0 value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant GeneralMetadataV0 other) {
    if (other == null) return false;

    if (  this.to_subaddress == other.to_subaddress  &&
      this.from_subaddress == other.from_subaddress  &&
      this.referenced_event == other.referenced_event  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.to_subaddress != null ? this.to_subaddress.hashCode : 0);
    value = 31 * value + (this.from_subaddress != null ? this.from_subaddress.hashCode : 0);
    value = 31 * value + (this.referenced_event != null ? this.referenced_event.hashCode : 0);
    return value;
  }

  GeneralMetadataV0.fromJson(dynamic json) :
    to_subaddress = json['to_subaddress'] ,
    from_subaddress = json['from_subaddress'] ,
    referenced_event = json['referenced_event'] ;

  dynamic toJson() => {
    "to_subaddress" : to_subaddress.isEmpty?null:to_subaddress.value ,
    "from_subaddress" : from_subaddress.isEmpty?null:from_subaddress.value ,
    "referenced_event" : referenced_event.isEmpty?null:referenced_event.value ,
  };
}
