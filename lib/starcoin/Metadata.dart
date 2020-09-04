part of starcoin_types;

abstract class Metadata {

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

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Metadata lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      Metadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
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
}
