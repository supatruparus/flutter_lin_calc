import 'package:flutter_lin_calc/domain/models/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/rulon_params.dart';

final rulonParamsProvider = StateProvider<RulonParams>((ref) {
  return const RulonParams();
});

final resultProvider = StateNotifierProvider<ResultNotifier, Result>((ref) {
  return ResultNotifier();
});

class ResultNotifier extends StateNotifier<Result> {
  ResultNotifier() : super(Result());

  calculatePloshad(RulonParams params) {
    bool haveNullParam =
        params.width == null || params.vitki == null || params.radius == null;
    bool zeroParam =
        params.width == 0 || params.vitki == 0 || params.radius == 0;
    if (!haveNullParam && !zeroParam) {
      double result = (params.radius! * 2 + 23) /
          100 *
          3.15 /
          2 *
          params.vitki! *
          params.width!;
      double length = result / params.width!;
      state = state.copyWith(ploshad: result, length: length);

      return result;
    } else {
      clear();
    }
  }

  clear() {
    state = state.copyWith(ploshad: -1, length: -1);
  }
}
