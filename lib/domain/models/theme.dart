import 'package:flutter/material.dart';

class AppTheme{
  AppTheme({this.bgColor, this.primaryColor, this.textStyle = const TextStyle()});
  final Color? bgColor;
  final Color? primaryColor;
  final TextStyle textStyle;
}