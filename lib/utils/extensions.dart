

extension ToSimpleString on num{

  String toSimpleString(){
    return this is int || this == this.roundToDouble() ? this.toInt().toString() : (this as double).toString();


  }

}