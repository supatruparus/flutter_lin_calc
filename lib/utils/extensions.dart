extension ToSimpleString on num {
  String toSimpleString() {
    return this is int || this == roundToDouble()
        ? toInt().toString()
        : (this as double).toString();
  }
}
