

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/rulon_params.dart';

final rulon = StateNotifierProvider<RulonNotifier, RulonParams>((ref) {
  return RulonNotifier();
});


class RulonNotifier extends StateNotifier<RulonParams> {
  RulonNotifier() : super(const RulonParams(width: 1, radius: 10, vitki: 10));
  
  

  
}
