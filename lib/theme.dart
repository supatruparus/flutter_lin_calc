import 'package:flutter/material.dart';

import 'consts/colors.dart';

ThemeData myTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.bgGrey,
    textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'MontserratAlternates',
          fontStyle: FontStyle.normal,
          fontSize: 32,
          color: MyColors.yelowtext,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'MontserratAlternates',
          fontStyle: FontStyle.normal,
          color: MyColors.yelowtext,
          fontSize: 42,
        )),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: MyColors.yelowtext,
        error: MyColors.yelowtext,
        secondary: MyColors.yelowtext));
