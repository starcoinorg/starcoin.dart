part of starcoin_types;

class AccountResource {
  Bytes authentication_key;
  Optional<WithdrawCapabilityResource> withdrawal_capability;
  Optional<KeyRotationCapabilityResource> key_rotation_capability;
  EventHandle received_events;
  EventHandle sent_events;
  EventHandle accept_token_events;
  int sequence_number;

  AccountResource(Bytes authentication_key, Optional<WithdrawCapabilityResource> withdrawal_capability, Optional<KeyRotationCapabilityResource> key_rotation_capability, EventHandle received_events, EventHandle sent_events, EventHandle accept_token_events, int sequence_number) {
    assert (authentication_key != null);
    assert (withdrawal_capability != null);
    assert (key_rotation_capability != null);
    assert (received_events != null);
    assert (sent_events != null);
    assert (accept_token_events != null);
    assert (sequence_number != null);
    this.authentication_key = authentication_key;
    this.withdrawal_capability = withdrawal_capability;
    this.key_rotation_capability = key_rotation_capability;
    this.received_events = received_events;
    this.sent_events = sent_events;
    this.accept_token_events = accept_token_events;
    this.sequence_number = sequence_number;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_bytes(authentication_key);
    TraitHelpers.serialize_option_WithdrawCapabilityResource(withdrawal_capability, serializer);
    TraitHelpers.serialize_option_KeyRotationCapabilityResource(key_rotation_capability, serializer);
    received_events.serialize(serializer);
    sent_events.serialize(serializer);
    accept_token_events.serialize(serializer);
    serializer.serialize_u64(sequence_number);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static AccountResource deserialize(BinaryDeserializer deserializer){
    var authentication_key = deserializer.deserialize_bytes();
    var withdrawal_capability = TraitHelpers.deserialize_option_WithdrawCapabilityResource(deserializer);
    var key_rotation_capability = TraitHelpers.deserialize_option_KeyRotationCapabilityResource(deserializer);
    var received_events = EventHandle.deserialize(deserializer);
    var sent_events = EventHandle.deserialize(deserializer);
    var accept_token_events = EventHandle.deserialize(deserializer);
    var sequence_number = deserializer.deserialize_u64();
    return new AccountResource(authentication_key,withdrawal_capability,key_rotation_capability,received_events,sent_events,accept_token_events,sequence_number);
  }

  static AccountResource lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      AccountResource value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant AccountResource other) {
    if (other == null) return false;

    if (  this.authentication_key == other.authentication_key  &&
      this.withdrawal_capability == other.withdrawal_capability  &&
      this.key_rotation_capability == other.key_rotation_capability  &&
      this.received_events == other.received_events  &&
      this.sent_events == other.sent_events  &&
      this.accept_token_events == other.accept_token_events  &&
      this.sequence_number == other.sequence_number  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.authentication_key != null ? this.authentication_key.hashCode : 0);
    value = 31 * value + (this.withdrawal_capability != null ? this.withdrawal_capability.hashCode : 0);
    value = 31 * value + (this.key_rotation_capability != null ? this.key_rotation_capability.hashCode : 0);
    value = 31 * value + (this.received_events != null ? this.received_events.hashCode : 0);
    value = 31 * value + (this.sent_events != null ? this.sent_events.hashCode : 0);
    value = 31 * value + (this.accept_token_events != null ? this.accept_token_events.hashCode : 0);
    value = 31 * value + (this.sequence_number != null ? this.sequence_number.hashCode : 0);
    return value;
  }

  AccountResource.fromJson(Map<String, dynamic> json) :
    authentication_key = Bytes.fromJson(json['authentication_key']) ,
    withdrawal_capability = json['withdrawal_capability'] ,
    key_rotation_capability = json['key_rotation_capability'] ,
    received_events = EventHandle.fromJson(json['received_events']) ,
    sent_events = EventHandle.fromJson(json['sent_events']) ,
    accept_token_events = EventHandle.fromJson(json['accept_token_events']) ,
    sequence_number = json['sequence_number'] ;

  Map<String, dynamic> toJson() => {
    "authentication_key" : authentication_key ,
    "withdrawal_capability" : withdrawal_capability.isEmpty?null:withdrawal_capability.value ,
    "key_rotation_capability" : key_rotation_capability.isEmpty?null:key_rotation_capability.value ,
    "received_events" : received_events ,
    "sent_events" : sent_events ,
    "accept_token_events" : accept_token_events ,
    "sequence_number" : sequence_number ,
  };
}
