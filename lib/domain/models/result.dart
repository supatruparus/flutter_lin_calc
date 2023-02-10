import 'package:flutter_lin_calc/domain/models/rulon_params.dart';

class Result{
  Result({ this.ploshad = -1,  this.length = -1});

  @override
  String toString() {
    return 'Result{ploshad: $ploshad, length: $length}';
  }

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