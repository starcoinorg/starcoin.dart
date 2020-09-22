part of starcoin_types;

class UnstructuredBytesMetadata {
  Optional<Bytes> metadata;

  UnstructuredBytesMetadata(Optional<Bytes> metadata) {
    assert (metadata != null);
    this.metadata = metadata;
  }

  void serialize(BinarySerializer serializer){
    TraitHelpers.serialize_option_bytes(metadata, serializer);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static UnstructuredBytesMetadata deserialize(BinaryDeserializer deserializer){
    var metadata = TraitHelpers.deserialize_option_bytes(deserializer);
    return new UnstructuredBytesMetadata(metadata);
  }

  static UnstructuredBytesMetadata lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      UnstructuredBytesMetadata value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant UnstructuredBytesMetadata other) {
    if (other == null) return false;

    if (  this.metadata == other.metadata  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.metadata != null ? this.metadata.hashCode : 0);
    return value;
  }

  UnstructuredBytesMetadata.fromJson(Map<String, dynamic> json) :
    metadata = json['metadata'] ;

  Map<String, dynamic> toJson() => {
    "metadata" : metadata.isEmpty?null:metadata.value ,
  };
}
