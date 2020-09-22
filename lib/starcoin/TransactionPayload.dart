part of starcoin_types;

abstract class TransactionPayload {
  TransactionPayload();

  void serialize(BinarySerializer serializer);

  static TransactionPayload deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionPayloadScriptItem.load(deserializer);
      case 1: return TransactionPayloadPackageItem.load(deserializer);
      default: throw new Exception("Unknown variant index for TransactionPayload: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TransactionPayload lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      TransactionPayload value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static TransactionPayload fromJson(Map<String, dynamic> json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TransactionPayloadScriptItem.loadJson(json);
      case 1: return TransactionPayloadPackageItem.loadJson(json);
      default: throw new Exception("Unknown type for TransactionPayload: " + type.toString());
    }
  }

  Map<String, dynamic> toJson();
}


class TransactionPayloadScriptItem extends TransactionPayload {
  Script value;

  TransactionPayloadScriptItem(Script value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static TransactionPayloadScriptItem load(BinaryDeserializer deserializer){
    var value = Script.deserialize(deserializer);
    return new TransactionPayloadScriptItem(value);
  }

  @override
  bool operator ==(covariant TransactionPayloadScriptItem other) {
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

  TransactionPayloadScriptItem.loadJson(Map<String, dynamic> json) :
    value = Script.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 0,
    "type_name" : "Script"
  };
}

class TransactionPayloadPackageItem extends TransactionPayload {
  Package value;

  TransactionPayloadPackageItem(Package value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    value.serialize(serializer);
  }

  static TransactionPayloadPackageItem load(BinaryDeserializer deserializer){
    var value = Package.deserialize(deserializer);
    return new TransactionPayloadPackageItem(value);
  }

  @override
  bool operator ==(covariant TransactionPayloadPackageItem other) {
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

  TransactionPayloadPackageItem.loadJson(Map<String, dynamic> json) :
    value = Package.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 1,
    "type_name" : "Package"
  };
}
