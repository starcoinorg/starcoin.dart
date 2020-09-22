part of starcoin_types;

abstract class PubSubParams {
  PubSubParams();

  void serialize(BinarySerializer serializer);

  static PubSubParams deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return PubSubParamsNoneItem.load(deserializer);
      case 1: return PubSubParamsEventsItem.load(deserializer);
      default: throw new Exception("Unknown variant index for PubSubParams: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static PubSubParams lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      PubSubParams value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static PubSubParams fromJson(Map<String, dynamic> json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return PubSubParamsNoneItem.loadJson(json);
      case 1: return PubSubParamsEventsItem.loadJson(json);
      default: throw new Exception("Unknown type for PubSubParams: " + type.toString());
    }
  }

  Map<String, dynamic> toJson();
}


class PubSubParamsNoneItem extends PubSubParams {
  PubSubParamsNoneItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
  }

  static PubSubParamsNoneItem load(BinaryDeserializer deserializer){
    return new PubSubParamsNoneItem();
  }

  @override
  bool operator ==(covariant PubSubParamsNoneItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  PubSubParamsNoneItem.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 0
  };
}

class PubSubParamsEventsItem extends PubSubParams {
  EventFilter value;

  PubSubParamsEventsItem(EventFilter value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    value.serialize(serializer);
  }

  static PubSubParamsEventsItem load(BinaryDeserializer deserializer){
    var value = EventFilter.deserialize(deserializer);
    return new PubSubParamsEventsItem(value);
  }

  @override
  bool operator ==(covariant PubSubParamsEventsItem other) {
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

  PubSubParamsEventsItem.loadJson(Map<String, dynamic> json) :
    value = EventFilter.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 1
  };
}
