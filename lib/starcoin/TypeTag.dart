part of starcoin_types;

abstract class TypeTag {
  TypeTag();

  void serialize(BinarySerializer serializer);

  static TypeTag deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TypeTagBoolItem.load(deserializer);
      case 1: return TypeTagU8Item.load(deserializer);
      case 2: return TypeTagU64Item.load(deserializer);
      case 3: return TypeTagU128Item.load(deserializer);
      case 4: return TypeTagAddressItem.load(deserializer);
      case 5: return TypeTagSignerItem.load(deserializer);
      case 6: return TypeTagVectorItem.load(deserializer);
      case 7: return TypeTagStructItem.load(deserializer);
      default: throw new Exception("Unknown variant index for TypeTag: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TypeTag lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      TypeTag value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static TypeTag fromJson(Map<String, dynamic> json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TypeTagBoolItem.loadJson(json);
      case 1: return TypeTagU8Item.loadJson(json);
      case 2: return TypeTagU64Item.loadJson(json);
      case 3: return TypeTagU128Item.loadJson(json);
      case 4: return TypeTagAddressItem.loadJson(json);
      case 5: return TypeTagSignerItem.loadJson(json);
      case 6: return TypeTagVectorItem.loadJson(json);
      case 7: return TypeTagStructItem.loadJson(json);
      default: throw new Exception("Unknown type for TypeTag: " + type.toString());
    }
  }

  Map<String, dynamic> toJson();
}


class TypeTagBoolItem extends TypeTag {
  TypeTagBoolItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
  }

  static TypeTagBoolItem load(BinaryDeserializer deserializer){
    return new TypeTagBoolItem();
  }

  @override
  bool operator ==(covariant TypeTagBoolItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagBoolItem.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 0
  };
}

class TypeTagU8Item extends TypeTag {
  TypeTagU8Item() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
  }

  static TypeTagU8Item load(BinaryDeserializer deserializer){
    return new TypeTagU8Item();
  }

  @override
  bool operator ==(covariant TypeTagU8Item other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagU8Item.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 1
  };
}

class TypeTagU64Item extends TypeTag {
  TypeTagU64Item() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(2);
  }

  static TypeTagU64Item load(BinaryDeserializer deserializer){
    return new TypeTagU64Item();
  }

  @override
  bool operator ==(covariant TypeTagU64Item other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagU64Item.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 2
  };
}

class TypeTagU128Item extends TypeTag {
  TypeTagU128Item() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(3);
  }

  static TypeTagU128Item load(BinaryDeserializer deserializer){
    return new TypeTagU128Item();
  }

  @override
  bool operator ==(covariant TypeTagU128Item other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagU128Item.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 3
  };
}

class TypeTagAddressItem extends TypeTag {
  TypeTagAddressItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(4);
  }

  static TypeTagAddressItem load(BinaryDeserializer deserializer){
    return new TypeTagAddressItem();
  }

  @override
  bool operator ==(covariant TypeTagAddressItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagAddressItem.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 4
  };
}

class TypeTagSignerItem extends TypeTag {
  TypeTagSignerItem() {
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(5);
  }

  static TypeTagSignerItem load(BinaryDeserializer deserializer){
    return new TypeTagSignerItem();
  }

  @override
  bool operator ==(covariant TypeTagSignerItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  TypeTagSignerItem.loadJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
    "type" : 5
  };
}

class TypeTagVectorItem extends TypeTag {
  TypeTag value;

  TypeTagVectorItem(TypeTag value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(6);
    value.serialize(serializer);
  }

  static TypeTagVectorItem load(BinaryDeserializer deserializer){
    var value = TypeTag.deserialize(deserializer);
    return new TypeTagVectorItem(value);
  }

  @override
  bool operator ==(covariant TypeTagVectorItem other) {
    if (other == null) return false;

    if (  this.value == other.value  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.value != null ? this.value.hashCode : 0);
    return value;
  }

  TypeTagVectorItem.loadJson(Map<String, dynamic> json) :
    value = TypeTag.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 6
  };
}

class TypeTagStructItem extends TypeTag {
  StructTag value;

  TypeTagStructItem(StructTag value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(7);
    value.serialize(serializer);
  }

  static TypeTagStructItem load(BinaryDeserializer deserializer){
    var value = StructTag.deserialize(deserializer);
    return new TypeTagStructItem(value);
  }

  @override
  bool operator ==(covariant TypeTagStructItem other) {
    if (other == null) return false;

    if (  this.value == other.value  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.value != null ? this.value.hashCode : 0);
    return value;
  }

  TypeTagStructItem.loadJson(Map<String, dynamic> json) :
    value = StructTag.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 7
  };
}
