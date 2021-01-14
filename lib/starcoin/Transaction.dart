part of starcoin_types;

abstract class Transaction {
  Transaction();

  void serialize(BinarySerializer serializer);

  static Transaction deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionUserTransactionItem.load(deserializer);
      case 1: return TransactionBlockMetadataItem.load(deserializer);
      default: throw new Exception("Unknown variant index for Transaction: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      var serializer = new BcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Transaction bcsDeserialize(Uint8List input)  {
     var deserializer = new BcsDeserializer(input);
      Transaction value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }

  static Transaction fromJson(dynamic json){
    final type = json['type'] as int;
    switch (type) {
      case 0: return TransactionUserTransactionItem.loadJson(json);
      case 1: return TransactionBlockMetadataItem.loadJson(json);
      default: throw new Exception("Unknown type for Transaction: " + type.toString());
    }
  }

  dynamic toJson();
}


class TransactionUserTransactionItem extends Transaction {
  SignedUserTransaction value;

  TransactionUserTransactionItem(SignedUserTransaction value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(0);
    value.serialize(serializer);
  }

  static TransactionUserTransactionItem load(BinaryDeserializer deserializer){
    var value = SignedUserTransaction.deserialize(deserializer);
    return new TransactionUserTransactionItem(value);
  }

  @override
  bool operator ==(covariant TransactionUserTransactionItem other) {
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

  TransactionUserTransactionItem.loadJson(dynamic json) :
    value = SignedUserTransaction.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 0,
    "type_name" : "UserTransaction"
  };
}

class TransactionBlockMetadataItem extends Transaction {
  BlockMetadata value;

  TransactionBlockMetadataItem(BlockMetadata value) {
    assert (value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer){
    serializer.serialize_variant_index(1);
    value.serialize(serializer);
  }

  static TransactionBlockMetadataItem load(BinaryDeserializer deserializer){
    var value = BlockMetadata.deserialize(deserializer);
    return new TransactionBlockMetadataItem(value);
  }

  @override
  bool operator ==(covariant TransactionBlockMetadataItem other) {
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

  TransactionBlockMetadataItem.loadJson(dynamic json) :
    value = BlockMetadata.fromJson(json['value']) ;

  dynamic toJson() => {
    "value" : value.toJson() ,
    "type" : 1,
    "type_name" : "BlockMetadata"
  };
}
