part of starcoin_types;

class ScriptFunction {
  ModuleId module;
  Identifier function;
  List<TypeTag> ty_args;
  List<Uint8List> args;

  ScriptFunction(ModuleId module, Identifier function, List<TypeTag> ty_args, List<Uint8List> args) {
    assert (module != null);
    assert (function != null);
    assert (ty_args != null);
    assert (args != null);
    this.module = module;
    this.function = function;
    this.ty_args = ty_args;
    this.args = args;
  }

  void serialize(BinarySerializer serializer){
    module.serialize(serializer);
    function.serialize(serializer);
    TraitHelpers.serialize_vector_TypeTag(ty_args, serializer);
    TraitHelpers.serialize_vector_bytes(args, serializer);
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static ScriptFunction deserialize(BinaryDeserializer deserializer){
    var module = ModuleId.deserialize(deserializer);
    var function = Identifier.deserialize(deserializer);
    var ty_args = TraitHelpers.deserialize_vector_TypeTag(deserializer);
    var args = TraitHelpers.deserialize_vector_bytes(deserializer);
    return new ScriptFunction(module,function,ty_args,args);
  }

  static ScriptFunction bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      ScriptFunction value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant ScriptFunction other) {
    if (other == null) return false;

    if (  this.module == other.module  &&
      this.function == other.function  &&
      isListsEqual(this.ty_args , other.ty_args)  &&
      isListsEqual(this.args , other.args)  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.module != null ? this.module.hashCode : 0);
    value = 31 * value + (this.function != null ? this.function.hashCode : 0);
    value = 31 * value + (this.ty_args != null ? this.ty_args.hashCode : 0);
    value = 31 * value + (this.args != null ? this.args.hashCode : 0);
    return value;
  }

  ScriptFunction.fromJson(dynamic json) :
    module = ModuleId.fromJson(json['module']) ,
    function = Identifier.fromJson(json['function']) ,
    ty_args = List<TypeTag>.from(json['ty_args'].map((f) => TypeTag.fromJson(f)).toList()) ,
    args = List<Uint8List>.from(json['args'].map((f) => Bytes.fromJson(f)).toList()) ;

  dynamic toJson() => {
    "module" : module.toJson() ,
    "function" : function.toJson() ,
    'ty_args' : ty_args.map((f) => f.toJson()).toList(),
    'args' : args.map((f) => f).toList(),
  };
}
