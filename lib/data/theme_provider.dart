import '../domain/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/consts/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final theme = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});




class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier()
      : super(
          AppTheme(
            primaryColor: MyColors.yelowtext,
            textStyle:  const TextStyle(
              fontFamily: 'MontserratAlternates',
              fontStyle: FontStyle.normal,
              fontSize: 32,
            ),
          ),
        ){
    state = AppTheme(primaryColor: state.primaryColor, textStyle: state.textStyle.copyWith(color: state.primaryColor), );
  }
}
