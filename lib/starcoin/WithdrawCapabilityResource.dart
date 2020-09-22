part of starcoin_types;

class WithdrawCapabilityResource {
  AccountAddress account_address;

  WithdrawCapabilityResource(AccountAddress account_address) {
    assert (account_address != null);
    this.account_address = account_address;
  }

  void serialize(BinarySerializer serializer){
    account_address.serialize(serializer);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static WithdrawCapabilityResource deserialize(BinaryDeserializer deserializer){
    var account_address = AccountAddress.deserialize(deserializer);
    return new WithdrawCapabilityResource(account_address);
  }

  static WithdrawCapabilityResource lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      WithdrawCapabilityResource value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant WithdrawCapabilityResource other) {
    if (other == null) return false;

    if (  this.account_address == other.account_address  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.account_address != null ? this.account_address.hashCode : 0);
    return value;
  }

  WithdrawCapabilityResource.fromJson(Map<String, dynamic> json) :
    account_address = AccountAddress.fromJson(json['account_address']) ;

  Map<String, dynamic> toJson() => {
    "account_address" : account_address ,
  };
}
