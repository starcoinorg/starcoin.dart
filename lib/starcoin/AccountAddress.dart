part of starcoin_types;

class AccountAddress {
  List<int> value;

  AccountAddress(List<int> value) {
    assert(value != null);
    this.value = value;
  }

  void serialize(BinarySerializer serializer) {
    TraitHelpers.serialize_array16_u8_array(value, serializer);
  }

  Uint8List bcsSerialize() {
    var serializer = new BcsSerializer();
    serialize(serializer);
    return serializer.get_bytes();
  }

  static AccountAddress deserialize(BinaryDeserializer deserializer) {
    var value = TraitHelpers.deserialize_array16_u8_array(deserializer);
    return new AccountAddress(value);
  }

  static AccountAddress bcsDeserialize(Uint8List input) {
    var deserializer = new BcsDeserializer(input);
    AccountAddress value = deserialize(deserializer);
    if (deserializer.get_buffer_offset() < input.length) {
      throw new Exception("Some input bytes were not read");
    }
    return value;
  }

  @override
  bool operator ==(covariant AccountAddress other) {
    if (other == null) return false;

    if (isListsEqual(this.value, other.value)) {
      return true;
    } else
      return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.value != null ? this.value.hashCode : 0);
    return value;
  }

  AccountAddress.fromJson(String json) : value = HEX.decode(json);

  String toJson() => HEX.encode(value);

  AccountAddress.fromHex(String json)
      : value = HEX.decode(json.replaceFirst("0x", ""));

  String toString() {
    return "0x" + HEX.encode(value);
  }
}
