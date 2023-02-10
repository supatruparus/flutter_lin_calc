import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/consts/colors.dart';
import 'package:flutter_lin_calc/presentation/main_page_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.bgGrey,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}




