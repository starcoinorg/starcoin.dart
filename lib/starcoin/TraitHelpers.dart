part of starcoin_types;
class TraitHelpers {
  static void serialize_array16_u8_array(List<int> value, BinarySerializer serializer) {
    assert (value.length == 16);
    for (int item in value) {
        serializer.serialize_u8(item);
    }
  }

  static List<int> deserialize_array16_u8_array(BinaryDeserializer deserializer) {
    List<int> obj = new List<int>.filled(16, 0);
    for (int i = 0; i < 16; i++) {
        obj[i] = deserializer.deserialize_u8();
    }
    return obj;
  }

  static void serialize_option_KeyRotationCapabilityResource(Optional<KeyRotationCapabilityResource> value, BinarySerializer serializer) {
    if (value.isPresent) {
        serializer.serialize_option_tag(true);
        value.value.serialize(serializer);
    } else {
        serializer.serialize_option_tag(false);
    }
  }

  static Optional<KeyRotationCapabilityResource> deserialize_option_KeyRotationCapabilityResource(BinaryDeserializer deserializer) {
    bool tag = deserializer.deserialize_option_tag();
    if (!tag) {
        return Optional.empty();
    } else {
        return Optional.of(KeyRotationCapabilityResource.deserialize(deserializer));
    }
  }

  static void serialize_option_WithdrawCapabilityResource(Optional<WithdrawCapabilityResource> value, BinarySerializer serializer) {
    if (value.isPresent) {
        serializer.serialize_option_tag(true);
        value.value.serialize(serializer);
    } else {
        serializer.serialize_option_tag(false);
    }
  }

  static Optional<WithdrawCapabilityResource> deserialize_option_WithdrawCapabilityResource(BinaryDeserializer deserializer) {
    bool tag = deserializer.deserialize_option_tag();
    if (!tag) {
        return Optional.empty();
    } else {
        return Optional.of(WithdrawCapabilityResource.deserialize(deserializer));
    }
  }

  static void serialize_option_bytes(Optional<Bytes> value, BinarySerializer serializer) {
    if (value.isPresent) {
        serializer.serialize_option_tag(true);
        serializer.serialize_bytes(value.value);
    } else {
        serializer.serialize_option_tag(false);
    }
  }

  static Optional<Bytes> deserialize_option_bytes(BinaryDeserializer deserializer) {
    bool tag = deserializer.deserialize_option_tag();
    if (!tag) {
        return Optional.empty();
    } else {
        return Optional.of(deserializer.deserialize_bytes());
    }
  }

  static void serialize_option_str(Optional<String> value, BinarySerializer serializer) {
    if (value.isPresent) {
        serializer.serialize_option_tag(true);
        serializer.serialize_str(value.value);
    } else {
        serializer.serialize_option_tag(false);
    }
  }

  static Optional<String> deserialize_option_str(BinaryDeserializer deserializer) {
    bool tag = deserializer.deserialize_option_tag();
    if (!tag) {
        return Optional.empty();
    } else {
        return Optional.of(deserializer.deserialize_str());
    }
  }

  static void serialize_option_u64(Optional<int> value, BinarySerializer serializer) {
    if (value.isPresent) {
        serializer.serialize_option_tag(true);
        serializer.serialize_u64(value.value);
    } else {
        serializer.serialize_option_tag(false);
    }
  }

  static Optional<int> deserialize_option_u64(BinaryDeserializer deserializer) {
    bool tag = deserializer.deserialize_option_tag();
    if (!tag) {
        return Optional.empty();
    } else {
        return Optional.of(deserializer.deserialize_u64());
    }
  }

  static void serialize_tuple2_AccessPath_WriteOp(Tuple2<AccessPath, WriteOp> value, BinarySerializer serializer) {
    value.item1.serialize(serializer);
    value.item2.serialize(serializer);
  }

  static Tuple2<AccessPath, WriteOp> deserialize_tuple2_AccessPath_WriteOp(BinaryDeserializer deserializer) {
    return new Tuple2<AccessPath, WriteOp>(
        AccessPath.deserialize(deserializer),
        WriteOp.deserialize(deserializer)
    );
  }

  static void serialize_vector_bytes(List<Uint8List> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (Uint8List item in value) {
      serializer.serialize_uint8list(item);
    }
  }

  static List<Uint8List> deserialize_vector_bytes(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<Uint8List> obj = new List(length);
    for (int i = 0; i < length; i++) {      
        obj[i]= deserializer.deserialize_uint8list();
    }
    return obj;
  }

  static void serialize_vector_ContractEvent(List<ContractEvent> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (ContractEvent item in value) {
        item.serialize(serializer);
    }
  }

  static List<ContractEvent> deserialize_vector_ContractEvent(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<ContractEvent> obj = new List<ContractEvent>(length);
    for (int i = 0; i < length; i++) {
        obj[i]=ContractEvent.deserialize(deserializer);
    }
    return obj;
  }

  static void serialize_vector_EventKey(List<EventKey> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (EventKey item in value) {
        item.serialize(serializer);
    }
  }

  static List<EventKey> deserialize_vector_EventKey(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<EventKey> obj = new List<EventKey>(length);
    for (int i = 0; i < length; i++) {
        obj[i]=EventKey.deserialize(deserializer);
    }
    return obj;
  }

  static void serialize_vector_Module(List<Module> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (Module item in value) {
        item.serialize(serializer);
    }
  }

  static List<Module> deserialize_vector_Module(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<Module> obj = new List<Module>(length);
    for (int i = 0; i < length; i++) {
        obj[i]=Module.deserialize(deserializer);
    }
    return obj;
  }

  static void serialize_vector_TypeTag(List<TypeTag> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (TypeTag item in value) {
        item.serialize(serializer);
    }
  }

  static List<TypeTag> deserialize_vector_TypeTag(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<TypeTag> obj = new List<TypeTag>(length);
    for (int i = 0; i < length; i++) {
        obj[i]=TypeTag.deserialize(deserializer);
    }
    return obj;
  }

  static void serialize_vector_tuple2_AccessPath_WriteOp(List<Tuple2<AccessPath, WriteOp>> value, BinarySerializer serializer) {
    serializer.serialize_len(value.length);
    for (Tuple2<AccessPath, WriteOp> item in value) {
        TraitHelpers.serialize_tuple2_AccessPath_WriteOp(item, serializer);
    }
  }

  static List<Tuple2<AccessPath, WriteOp>> deserialize_vector_tuple2_AccessPath_WriteOp(BinaryDeserializer deserializer) {
    int length = deserializer.deserialize_len();
    List<Tuple2<AccessPath, WriteOp>> obj = new List<Tuple2<AccessPath, WriteOp>>(length);
    for (int i = 0; i < length; i++) {
        obj[i]=TraitHelpers.deserialize_tuple2_AccessPath_WriteOp(deserializer);
    }
    return obj;
  }

}

