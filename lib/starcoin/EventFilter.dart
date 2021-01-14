part of starcoin_types;

class EventFilter {
  Optional<int> from_block;
  Optional<int> to_block;
  List<EventKey> event_keys;
  Optional<int> limit;

  EventFilter(Optional<int> from_block, Optional<int> to_block, List<EventKey> event_keys, Optional<int> limit) {
    assert (from_block != null);
    assert (to_block != null);
    assert (event_keys != null);
    assert (limit != null);
    this.from_block = from_block;
    this.to_block = to_block;
    this.event_keys = event_keys;
    this.limit = limit;
  }

  void serialize(BinarySerializer serializer){
    TraitHelpers.serialize_option_u64(from_block, serializer);
    TraitHelpers.serialize_option_u64(to_block, serializer);
    TraitHelpers.serialize_vector_EventKey(event_keys, serializer);
    TraitHelpers.serialize_option_u64(limit, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static EventFilter deserialize(BinaryDeserializer deserializer){
    var from_block = TraitHelpers.deserialize_option_u64(deserializer);
    var to_block = TraitHelpers.deserialize_option_u64(deserializer);
    var event_keys = TraitHelpers.deserialize_vector_EventKey(deserializer);
    var limit = TraitHelpers.deserialize_option_u64(deserializer);
    return new EventFilter(from_block,to_block,event_keys,limit);
  }

  static EventFilter bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      EventFilter value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant EventFilter other) {
    if (other == null) return false;

    if (  this.from_block == other.from_block  &&
      this.to_block == other.to_block  &&
      isListsEqual(this.event_keys , other.event_keys)  &&
      this.limit == other.limit  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.from_block != null ? this.from_block.hashCode : 0);
    value = 31 * value + (this.to_block != null ? this.to_block.hashCode : 0);
    value = 31 * value + (this.event_keys != null ? this.event_keys.hashCode : 0);
    value = 31 * value + (this.limit != null ? this.limit.hashCode : 0);
    return value;
  }

  EventFilter.fromJson(dynamic json) :
    from_block = json['from_block'] ,
    to_block = json['to_block'] ,
    event_keys = List<EventKey>.from(json['event_keys'].map((f) => EventKey.fromJson(f)).toList()) ,
    limit = json['limit'] ;

  dynamic toJson() => {
    "from_block" : from_block.isEmpty?null:from_block.value ,
    "to_block" : to_block.isEmpty?null:to_block.value ,
    'event_keys' : event_keys.map((f) => f.toJson()).toList(),
    "limit" : limit.isEmpty?null:limit.value ,
  };
}
