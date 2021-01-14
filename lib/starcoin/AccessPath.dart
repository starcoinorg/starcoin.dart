part of starcoin_types;

class AccessPath {
  AccountAddress address;
  DataPath path;

  AccessPath(AccountAddress address, DataPath path) {
    assert (address != null);
    assert (path != null);
    this.address = address;
    this.path = path;
  }

  void serialize(BinarySerializer serializer){
    address.serialize(serializer);
    path.serialize(serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static AccessPath deserialize(BinaryDeserializer deserializer){
    var address = AccountAddress.deserialize(deserializer);
    var path = DataPath.deserialize(deserializer);
    return new AccessPath(address,path);
  }

  static AccessPath bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      AccessPath value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant AccessPath other) {
    if (other == null) return false;

    if (  this.address == other.address  &&
      this.path == other.path  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.address != null ? this.address.hashCode : 0);
    value = 31 * value + (this.path != null ? this.path.hashCode : 0);
    return value;
  }

  AccessPath.fromJson(dynamic json) :
    address = AccountAddress.fromJson(json['address']) ,
    path = DataPath.fromJson(json['path']) ;

  dynamic toJson() => {
    "address" : address.toJson() ,
    "path" : path.toJson() ,
  };
}
