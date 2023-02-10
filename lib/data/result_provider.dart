


import 'package:flutter_lin_calc/domain/models/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/rulon_params.dart';



final rulonParamsProvider = StateProvider<RulonParams>((ref) {
  return const RulonParams(vitki: 0, radius: 0, width: 1);
});


final resultProvider = StateNotifierProvider<ResultNotifier,Result >((ref) {
  return ResultNotifier();

});

class ResultNotifier extends StateNotifier<Result> {
  ResultNotifier() : super(Result(length: 0, ploshad: 0));

  double calculatePloshad(RulonParams params){
    print('params: ${params.toString()} ');
    double result = (params.radius*2 + 23)/100*3.15/2*params.vitki*params.width;
    double length = result/params.width;
    state = state.copyWith(ploshad: result, length: length);

    print('ploshad = $result, dlina = $length');
    return result;

  }




}
