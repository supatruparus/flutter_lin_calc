import 'package:flutter/widgets.dart';
import 'package:flutter_lin_calc/data/result_provider.dart';
import 'package:flutter_lin_calc/domain/models/history_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinCalcApp {
  LinCalcApp(this.ref);
  ProviderRef ref;
  late final HistoryList _historyListRep =
      ref.read(historyListProvider.notifier);

  onSaveResult() {
    _historyListRep.add(ref.read(resultProvider));
    debugPrint('history: ${_historyListRep.state}');
  }
}

final linCalcAppProvider = Provider<LinCalcApp>((ref) {
  return LinCalcApp(ref);
});

LinCalcApp lincalcApp(WidgetRef ref) => ref.read(linCalcAppProvider);
