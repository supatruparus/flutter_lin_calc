import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/consts/colors.dart';
import 'package:flutter_lin_calc/presentation/history_page.dart';
import 'package:flutter_lin_calc/presentation/main_page_view.dart';
import 'package:flutter_lin_calc/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme,
        home: PageView(
          padEnds: false,
          children: const [MyHomePage(), HistoryPage()],
        ),
      ),
    );
  }
}
