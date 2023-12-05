import 'package:flutter/material.dart';

extension SelectAll on TextEditingController {
  selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
