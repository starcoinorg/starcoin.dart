part of starcoin_types;

class StructTag {
  AccountAddress address;
  Identifier module;
  Identifier name;
  List<TypeTag> type_params;

  StructTag(AccountAddress address, Identifier module, Identifier name, List<TypeTag> type_params) {
    assert (address != null);
    assert (module != null);
    assert (name != null);
    assert (type_params != null);
    this.address = address;
    this.module = module;
    this.name = name;
    this.type_params = type_params;
  }

  void serialize(BinarySerializer serializer){
    address.serialize(serializer);
    module.serialize(serializer);
    name.serialize(serializer);
    TraitHelpers.serialize_vector_TypeTag(type_params, serializer);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static StructTag deserialize(BinaryDeserializer deserializer){
    var address = AccountAddress.deserialize(deserializer);
    var module = Identifier.deserialize(deserializer);
    var name = Identifier.deserialize(deserializer);
    var type_params = TraitHelpers.deserialize_vector_TypeTag(deserializer);
    return new StructTag(address,module,name,type_params);
  }

  static StructTag lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      StructTag value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant StructTag other) {
    if (other == null) return false;

    if (  this.address == other.address  &&
      this.module == other.module  &&
      this.name == other.name  &&
      isListsEqual(this.type_params , other.type_params)  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.address != null ? this.address.hashCode : 0);
    value = 31 * value + (this.module != null ? this.module.hashCode : 0);
    value = 31 * value + (this.name != null ? this.name.hashCode : 0);
    value = 31 * value + (this.type_params != null ? this.type_params.hashCode : 0);
    return value;
  }
}
