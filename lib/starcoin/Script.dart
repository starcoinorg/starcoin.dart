part of starcoin_types;

class Script {
  Bytes code;
  List<TypeTag> ty_args;
  List<TransactionArgument> args;

  Script(Bytes code, List<TypeTag> ty_args, List<TransactionArgument> args) {
    assert (code != null);
    assert (ty_args != null);
    assert (args != null);
    this.code = code;
    this.ty_args = ty_args;
    this.args = args;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_bytes(code);
    TraitHelpers.serialize_vector_TypeTag(ty_args, serializer);
    TraitHelpers.serialize_vector_TransactionArgument(args, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Script deserialize(BinaryDeserializer deserializer){
    var code = deserializer.deserialize_bytes();
    var ty_args = TraitHelpers.deserialize_vector_TypeTag(deserializer);
    var args = TraitHelpers.deserialize_vector_TransactionArgument(deserializer);
    return new Script(code,ty_args,args);
  }

  static Script bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      Script value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant Script other) {
    if (other == null) return false;

    if (  this.code == other.code  &&
      isListsEqual(this.ty_args , other.ty_args)  &&
      isListsEqual(this.args , other.args)  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.code != null ? this.code.hashCode : 0);
    value = 31 * value + (this.ty_args != null ? this.ty_args.hashCode : 0);
    value = 31 * value + (this.args != null ? this.args.hashCode : 0);
    return value;
  }

  Script.fromJson(dynamic json) :
    code = Bytes.fromJson(json['code']) ,
    ty_args = List<TypeTag>.from(json['ty_args'].map((f) => TypeTag.fromJson(f)).toList()) ,
    args = List<TransactionArgument>.from(json['args'].map((f) => TransactionArgument.fromJson(f)).toList()) ;

  dynamic toJson() => {
    "code" : code.toJson() ,
    'ty_args' : ty_args.map((f) => f.toJson()).toList(),
    'args' : args.map((f) => f.toJson()).toList(),
  };
}
