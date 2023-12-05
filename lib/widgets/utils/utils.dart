import 'package:flutter/material.dart';

extension SelectAll on TextEditingController {
  selectAll() {
    selection = const TextSelection(baseOffset: 0, extentOffset: 99999);
  }
}
