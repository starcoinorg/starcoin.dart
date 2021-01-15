part of starcoin_types;

class BalanceResource {
  Int128 token;

  BalanceResource(Int128 token) {
    assert (token != null);
    this.token = token;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_u128(token);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static BalanceResource deserialize(BinaryDeserializer deserializer){
    var token = deserializer.deserialize_u128();
    return new BalanceResource(token);
  }

  static BalanceResource bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      BalanceResource value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant BalanceResource other) {
    if (other == null) return false;

    if (  this.token == other.token  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    return value;
  }

  BalanceResource.fromJson(dynamic json) :
    token = json['token'] ;

  dynamic toJson() => {
    "token" : token ,
  };
}
