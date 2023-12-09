import 'dart:convert';

import 'package:flutter_lin_calc/data/local_storage.dart';
import 'package:flutter_lin_calc/data/result_provider.dart';
import 'package:flutter_lin_calc/domain/models/lin_calc_app.dart';
import 'package:flutter_lin_calc/domain/models/rulon_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../domain/models/history_list.dart';

final viewModelProvider =
    StateNotifierProvider<LinCalcAppNotifier, dynamic>((ref) {
  return LinCalcAppNotifier(ref);
});

class LinCalcAppNotifier extends StateNotifier implements LinCalcApp {
  LinCalcAppNotifier(this.ref) : super(null);
  final StateNotifierProviderRef<LinCalcAppNotifier, dynamic> ref;
  final MyLocalStorage _localStorage = MyLocalStorage();
  PageController widthController = PageController(initialPage: 0);
  PageController vitkiController = PageController(initialPage: 0);

  PageController radiusController =
      PageController(initialPage: 0, viewportFraction: 0.6);
  late final _result = ref.read(resultProvider);
  ResultNotifier get resultRep => ref.read(resultProvider.notifier);

  RulonParams get rulonParams => ref.read(rulonParamsProvider);
  late final _rulonParamsRep = ref.read(rulonParamsProvider.notifier);
  late final HistoryList _historyListRep =
      ref.read(historyListProvider.notifier);
  onPickWidth(double? width) async {
    _rulonParamsRep.update((state) => state.copyWith(width: width));
    onChangeParam();
  }

  onPickVitki(int? vitki) {
    _rulonParamsRep.update((state) => state.copyWith(vitki: vitki));
    onChangeParam();
  }

  onPickRadius(double? radius) {
    _rulonParamsRep.update((state) => state.copyWith(radius: radius));
    onChangeParam();
  }

  @override
  onChangeParam() {
    if (rulonParams.isNotZero) {
      resultRep.calculatePloshad(rulonParams);
    }
  }

  @override
  onSaveResult() async {
    if (_result.ploshad != 0 || _result.length != 0) {
      _historyListRep.add(ref.read(resultProvider));
      await _localStorage.writeStringToFile(
          'history.txt', jsonEncode(_historyListRep.state));
      String fileString = await _localStorage.readStringFromFile('history.txt');
    }
    debugPrint('history: ${_historyListRep.state}');
  }
}
