import 'package:flutter/material.dart';

extension SelectAll on TextEditingController {
  selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

extension ReplaceLast on String {
  String replaceLastChar(String symbol) {
    String newString = substring(0, length - 1);
    newString = '$newString$symbol';
    return newString;
  }
}

extension IsNumber on String {
  bool get isNumber {
    bool result = true;
    for (var rune in runes) {
      // Если символ это число от 0 до 9
      if (rune >= 48 && rune <= 57) {
      } else {
        result = false;
        break;
      }
    }
    return result;
  }

  bool get isParsable {
    bool isParsable = double.tryParse(this) != null;
    return isParsable;
  }
}

extension RemoveLast on String {
  String removeLast() {
    return substring(0, length - 1);
  }
}

extension FormatLast on TextEditingController {
  ///Заменяет введенную запятую на точку, не дает ввести ничего кроме цифр
  formatLastInput() {
    if (text.isNotEmpty) {
      if (text.endsWith(',')) {
        text = text.replaceLastChar('.');
        selection = TextSelection.collapsed(
            offset: text.length, affinity: TextAffinity.downstream);
      } else {
        //  если символ не число и не точка удалить последний
        if (!text.characters.last.isNumber && text.characters.last != '.') {
          text = text.removeLast();
          selection = TextSelection.collapsed(
              offset: text.length, affinity: TextAffinity.downstream);
        }
      }

      ///Если введена точка но точка уже была
      if (text.endsWith('.')) {
        if (text.removeLast().contains('.')) {
          print('text содержит точку: $text');
          text = text.removeLast();
          selection = TextSelection.collapsed(
              offset: text.length, affinity: TextAffinity.downstream);
        }
      }
    }
  }
}
