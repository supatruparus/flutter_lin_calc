import 'package:flutter_lin_calc/data/result_provider.dart';
import 'package:flutter_lin_calc/domain/models/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryList extends StateNotifier<List<Result>> {
  HistoryList(this.ref) : super([]);
  StateNotifierProviderRef ref;
  add(Result result) {
    final List<Result> newList = List.from(state);
    newList.add(result);
    state = newList;
  }
}

final historyListProvider =
    StateNotifierProvider<HistoryList, List<Result>>((ref) {
  return HistoryList(ref);
});
