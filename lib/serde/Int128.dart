part of serde;

class Int128 {
  int high;
  int low;

  Int128(int high, int low) {
    this.high = high;
    this.low = low;
  }

  Int128 fromBigInt(BigInt num) {
    high = (num >> 64).toInt();
    low = (num & BigInt.from(0xFFFFFFFFFFFFFFFF)).toInt();
    return Int128(high, low);
  }

  @override
  bool operator ==(covariant Int128 other) {
    if (other == null) return false;
    if (this.high == other.high && this.low == other.low) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => $jf($jc(this.high.hashCode, this.low));

  @override
  String toString() {
    return "$high$low";
  }
}
