import 'package:flutter_lin_calc/domain/models/rulon_params.dart';

class Result{
  Result({required this.ploshad, required this.length});
  final double ploshad;
  final double length;

  Result copyWith({
    double? ploshad,
    double? length,
  }) {
    return Result(
      ploshad: ploshad ?? this.ploshad,
      length: length ?? this.length,
    );
  }
}