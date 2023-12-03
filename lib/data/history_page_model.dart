import 'package:flutter_lin_calc/domain/models/history_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/result.dart';

class HistoryPageModel {
  HistoryPageModel(this.ref) {}
  final WidgetRef ref;

  late final List<Result> resultsList = ref.watch(historyListProvider);
}
