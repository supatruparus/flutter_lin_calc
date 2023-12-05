import 'package:flutter_lin_calc/data/lin_calc_app_rep.dart';
import 'package:flutter_lin_calc/domain/models/width_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final widthControllerProvider = Provider<ScrollInputController>((ref) {
  return ScrollInputController(
      page:
          ref.watch(viewModelProvider.notifier).widthController.page!.toInt());
});
