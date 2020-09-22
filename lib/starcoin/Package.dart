part of starcoin_types;

class Package {
  AccountAddress package_address;
  List<Module> modules;
  Script init_script;

  Package(AccountAddress package_address, List<Module> modules, Script init_script) {
    assert (package_address != null);
    assert (modules != null);
    assert (init_script != null);
    this.package_address = package_address;
    this.modules = modules;
    this.init_script = init_script;
  }

  void serialize(BinarySerializer serializer){
    package_address.serialize(serializer);
    TraitHelpers.serialize_vector_Module(modules, serializer);
    init_script.serialize(serializer);
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Package deserialize(BinaryDeserializer deserializer){
    var package_address = AccountAddress.deserialize(deserializer);
    var modules = TraitHelpers.deserialize_vector_Module(deserializer);
    var init_script = Script.deserialize(deserializer);
    return new Package(package_address,modules,init_script);
  }

  static Package lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      Package value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  @override
  bool operator ==(covariant Package other) {
    if (other == null) return false;

    if (  this.package_address == other.package_address  &&
      isListsEqual(this.modules , other.modules)  &&
      this.init_script == other.init_script  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.package_address != null ? this.package_address.hashCode : 0);
    value = 31 * value + (this.modules != null ? this.modules.hashCode : 0);
    value = 31 * value + (this.init_script != null ? this.init_script.hashCode : 0);
    return value;
  }

  Package.fromJson(Map<String, dynamic> json) :
    package_address = AccountAddress.fromJson(json['package_address']) ,
    modules = List<Module>.from(json['modules'].map((f) => Module.fromJson(f)).toList()) ,
    init_script = Script.fromJson(json['init_script']) ;

  Map<String, dynamic> toJson() => {
    "package_address" : package_address ,
    "modules" : modules ,
    "init_script" : init_script ,
  };
}
