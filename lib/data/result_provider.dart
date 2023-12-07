import 'package:flutter_lin_calc/domain/models/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/rulon_params.dart';

final rulonParamsProvider = StateProvider<RulonParams>((ref) {
  return const RulonParams();
});

final resultProvider = StateNotifierProvider<ResultNotifier, Result>((ref) {
  final rulonParams = ref.read(rulonParamsProvider);
  return ResultNotifier(Result(
      radius: rulonParams.radius,
      width: rulonParams.width,
      vitki: rulonParams.vitki,
      length: 0,
      ploshad: 0));
});

class ResultNotifier extends StateNotifier<Result> {
  ResultNotifier(super._state);

  calculatePloshad(RulonParams params) {
    double result =
        (params.radius * 2 + 23) / 100 * 3.15 / 2 * params.vitki * params.width;
    double length = result / params.width;
    state = state.copyWith(
        ploshad: result,
        length: length,
        vitki: params.vitki,
        radius: params.radius,
        width: params.width);

    return result;
  }
}
