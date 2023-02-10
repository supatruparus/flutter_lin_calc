import 'package:flutter_lin_calc/data/page_view_model_provider.dart';
import 'package:flutter_lin_calc/domain/models/width_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final widthControllerProvider = Provider<ScrollInputController>((ref) {
  return ScrollInputController(page: ref.watch(viewModelProvider.notifier).widthController.page!.toInt());
});
