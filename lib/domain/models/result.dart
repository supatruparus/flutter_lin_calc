import 'package:json_annotation/json_annotation.dart';

class Result extends JsonSerializable {
  Result(
      {required this.ploshad,
      required this.length,
      required this.width,
      required this.vitki,
      required this.radius});

  @override
  String toString() {
    return 'Result{ploshad=$ploshad, length=$length, width=$width, vitki=$vitki, radius=$radius}';
  }

  final double ploshad;
  final double length;
  final double width;
  final int vitki;
  final double radius;

  Result copyWith(
      {double? ploshad,
      double? length,
      double? width,
      int? vitki,
      double? radius}) {
    return Result(
        ploshad: ploshad ?? this.ploshad,
        length: length ?? this.length,
        width: width ?? this.width,
        vitki: vitki ?? this.vitki,
        radius: radius ?? this.radius);
  }
}
