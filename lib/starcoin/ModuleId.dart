part of starcoin_types;

class ModuleId {
  AccountAddress address;
  Identifier name;

  ModuleId(AccountAddress address, Identifier name) {
    assert (address != null);
    assert (name != null);
    this.address = address;
    this.name = name;
  }

  void serialize(BinarySerializer serializer){
    address.serialize(serializer);
    name.serialize(serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static ModuleId deserialize(BinaryDeserializer deserializer){
    var address = AccountAddress.deserialize(deserializer);
    var name = Identifier.deserialize(deserializer);
    return new ModuleId(address,name);
  }

  static ModuleId bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      ModuleId value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant ModuleId other) {
    if (other == null) return false;

    if (  this.address == other.address  &&
      this.name == other.name  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.address != null ? this.address.hashCode : 0);
    value = 31 * value + (this.name != null ? this.name.hashCode : 0);
    return value;
  }

  ModuleId.fromJson(dynamic json) :
    address = AccountAddress.fromJson(json['address']) ,
    name = Identifier.fromJson(json['name']) ;

  dynamic toJson() => {
    "address" : address.toJson() ,
    "name" : name.toJson() ,
  };
}
