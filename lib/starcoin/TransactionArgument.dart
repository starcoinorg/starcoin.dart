part of starcoin_types;

abstract class TransactionArgument {
  TransactionArgument();

  void serialize(BinarySerializer serializer);

  static TransactionArgument deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionArgumentU8Item.load(deserializer);
      case 1: return TransactionArgumentU64Item.load(deserializer);
      case 2: return TransactionArgumentU128Item.load(deserializer);
      case 3: return TransactionArgumentAddressItem.load(deserializer);
      case 4: return TransactionArgumentU8VectorItem.load(deserializer);
      case 5: return TransactionArgumentBoolItem.load(deserializer);
      default: throw new Exception("Unknown variant index for TransactionArgument: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static TransactionArgument lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      TransactionArgument value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static TransactionArgument fromJson(Map<String, dynamic> json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TransactionArgumentU8Item.loadJson(json);
      case 1: return TransactionArgumentU64Item.loadJson(json);
      case 2: return TransactionArgumentU128Item.loadJson(json);
      case 3: return TransactionArgumentAddressItem.loadJson(json);
      case 4: return TransactionArgumentU8VectorItem.loadJson(json);
      case 5: return TransactionArgumentBoolItem.loadJson(json);
      default: throw new Exception("Unknown type for TransactionArgument: " + type.toString());
    }
  }

  Map<String, dynamic> toJson();
}


class TransactionArgumentU8Item extends TransactionArgument {
  int value;

  TransactionArgumentU8Item(int value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    serializer.serialize_u8(value);
  }

  static TransactionArgumentU8Item load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_u8();
    return new TransactionArgumentU8Item(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentU8Item other) {
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

  TransactionArgumentU8Item.loadJson(Map<String, dynamic> json) :
    value = json['value'] ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 0
  };
}

class TransactionArgumentU64Item extends TransactionArgument {
  int value;

  TransactionArgumentU64Item(int value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    serializer.serialize_u64(value);
  }

  static TransactionArgumentU64Item load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_u64();
    return new TransactionArgumentU64Item(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentU64Item other) {
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

  TransactionArgumentU64Item.loadJson(Map<String, dynamic> json) :
    value = json['value'] ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 1
  };
}

class TransactionArgumentU128Item extends TransactionArgument {
  Int128 value;

  TransactionArgumentU128Item(Int128 value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(2);
    serializer.serialize_u128(value);
  }

  static TransactionArgumentU128Item load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_u128();
    return new TransactionArgumentU128Item(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentU128Item other) {
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

  TransactionArgumentU128Item.loadJson(Map<String, dynamic> json) :
    value = json['value'] ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 2
  };
}

class TransactionArgumentAddressItem extends TransactionArgument {
  AccountAddress value;

  TransactionArgumentAddressItem(AccountAddress value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(3);
    value.serialize(serializer);
  }

  static TransactionArgumentAddressItem load(BinaryDeserializer deserializer){
    var value = AccountAddress.deserialize(deserializer);
    return new TransactionArgumentAddressItem(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentAddressItem other) {
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

  TransactionArgumentAddressItem.loadJson(Map<String, dynamic> json) :
    value = AccountAddress.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 3
  };
}

class TransactionArgumentU8VectorItem extends TransactionArgument {
  Bytes value;

  TransactionArgumentU8VectorItem(Bytes value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(4);
    serializer.serialize_bytes(value);
  }

  static TransactionArgumentU8VectorItem load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_bytes();
    return new TransactionArgumentU8VectorItem(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentU8VectorItem other) {
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

  TransactionArgumentU8VectorItem.loadJson(Map<String, dynamic> json) :
    value = Bytes.fromJson(json['value']) ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 4
  };
}

class TransactionArgumentBoolItem extends TransactionArgument {
  bool value;

  TransactionArgumentBoolItem(bool value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(5);
    serializer.serialize_bool(value);
  }

  static TransactionArgumentBoolItem load(BinaryDeserializer deserializer){
    var value = deserializer.deserialize_bool();
    return new TransactionArgumentBoolItem(value);
  }

  @override
  bool operator ==(covariant TransactionArgumentBoolItem other) {
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

  TransactionArgumentBoolItem.loadJson(Map<String, dynamic> json) :
    value = json['value'] ;

  Map<String, dynamic> toJson() => {
    "value" : value ,
    "type" : 5
  };
}
