class RulonParams{
  const RulonParams({required this.vitki, required this.radius, required this.width});
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
}