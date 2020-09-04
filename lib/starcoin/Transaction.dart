part of starcoin_types;

abstract class Transaction {

  void serialize(BinarySerializer serializer);

  static Transaction deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserialize_variant_index();
    switch (index) {
      case 0: return TransactionUserTransactionItem.load(deserializer);
      case 1: return TransactionBlockMetadataItem.load(deserializer);
      default: throw new Exception("Unknown variant index for Transaction: " + index.toString());
    }
  }

  Uint8List lcsSerialize() {
      var serializer = new LcsSerializer();
      serialize(serializer);
      return serializer.get_bytes();
  }

  static Transaction lcsDeserialize(Uint8List input)  {
     var deserializer = new LcsDeserializer(input);
      Transaction value = deserialize(deserializer);
      if (deserializer.get_buffer_offset() < input.length) {
           throw new Exception("Some input bytes were not read");
      }
      return value;
  }
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
}
