part of starcoin_types;

abstract class GeneralMetadata {

  void serialize(BinarySerializer serializer);

  static GeneralMetadata deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return GeneralMetadataGeneralMetadataVersion0Item.load(deserializer);
      default: throw new Exception("Unknown variant index for GeneralMetadata: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static GeneralMetadata lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      GeneralMetadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
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
}
