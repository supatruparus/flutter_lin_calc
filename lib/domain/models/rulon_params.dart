class RulonParams {
  const RulonParams({this.vitki = 0, this.radius = 0, this.width = 0});

  @override
  String toString() {
    return 'RulonParams{vitki: $vitki, radius: $radius, width: $width}';
  }

  final int vitki;
  final double radius;
  final double width;

  RulonParams copyWith({
    int? vitki,
    double? radius,
    double? width,
  }) {
    return RulonParams(
      vitki: vitki ?? this.vitki,
      radius: radius ?? this.radius,
      width: width ?? this.width,
    );
  }

  bool get isNotZero {
    if (vitki == 0 || radius == 0 || width == 0) {
      return false;
    } else {
      return true;
    }
  }

  List<Object?> get props => [vitki, radius, width];
}
