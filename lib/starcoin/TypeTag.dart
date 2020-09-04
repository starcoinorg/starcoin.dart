part of starcoin_types;

abstract class TypeTag {

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
}
