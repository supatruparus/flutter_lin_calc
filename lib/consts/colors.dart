import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

abstract class MyColors{
  static Color bgGrey = const Color.fromRGBO(29, 29, 29, 1);
  static Color dark = const Color.fromRGBO(30, 30, 30, 1);
  static Color yelowtext = const Color.fromRGBO(255, 237, 172, 1);

}

InnerShadow innerShadow1(Widget child){
  return InnerShadow(
    shadows: [Shadow(color: Colors.red.withOpacity(0.25), blurRadius: 20, offset: const Offset(2,3))],
    child: child,
  );
}

