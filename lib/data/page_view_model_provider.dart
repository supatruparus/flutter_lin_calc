import 'package:flutter_lin_calc/data/result_provider.dart';
import 'package:flutter_lin_calc/data/width_controller.dart';
import 'package:flutter_lin_calc/data/width_variants.dart';
import 'package:flutter_lin_calc/domain/models/rulon_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final viewModelProvider = StateNotifierProvider<ViewModelNotifier, dynamic>((ref) {
  return ViewModelNotifier(ref);
});

class ViewModelNotifier extends StateNotifier {
  ViewModelNotifier(this.ref) : super(null);
  final StateNotifierProviderRef<ViewModelNotifier, dynamic> ref;

  PageController widthController = PageController(initialPage: 0);
  PageController vitkiController = PageController(initialPage: 0);
  PageController radiusController = PageController(initialPage: 0);


  ResultNotifier get result => ref.read(resultProvider.notifier);

  set _rulonParams(RulonParams params) {
    ref.read(rulonParamsProvider.notifier).update((state) => state);
  }

  RulonParams get _rulonParams => ref.read(rulonParamsProvider);

  onPickWidth(double width) async {
    ref.read(rulonParamsProvider.notifier).update((state) => state.copyWith(width: width));
    print('width: ${_rulonParams.width}');
    result.calculatePloshad(_rulonParams);
  }

  onPickVitki(int vitki) {
    ref.read(rulonParamsProvider.notifier).update((state) => state.copyWith(vitki: vitki));
    print('vitki: ${_rulonParams.vitki}');
    result.calculatePloshad(_rulonParams);
  }

  onPickRadius(double radius) {
    ref.read(rulonParamsProvider.notifier).update((state) => state.copyWith(radius: radius));
    print('radius: ${_rulonParams.radius}');
    result.calculatePloshad(_rulonParams);
  }
}
