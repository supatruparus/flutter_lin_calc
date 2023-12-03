import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/data/history_page_model.dart';
import 'package:flutter_lin_calc/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/result.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = HistoryPageModel(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                  children: List.generate(
                      model.resultsList.length,
                      (index) => _Card(
                            result: model.resultsList[index],
                          ))),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key, required this.result}) : super(key: key);
  final Result result;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        'Площадь: ${result.ploshad.toStringAsFixed(3)}, Длина: ${result.length}',
      ),
    );
  }
}
