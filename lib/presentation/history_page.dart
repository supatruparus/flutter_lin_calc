import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/data/history_page_model.dart';

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
          child: ListView.separated(
              itemBuilder: (context, index) => Card(
                    child: _Card(
                      onRemove: () {
                        model.onRemoveItem(index);
                      },
                      result: model.resultsList[index],
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: model.resultsList.length),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key, required this.onRemove, required this.result})
      : super(key: key);
  final Result result;
  final Function() onRemove;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10, bottom: 6, top: 6),
      enableFeedback: true,
      focusColor: Colors.amber,
      hoverColor: Colors.red,
      title: FittedBox(
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: IconButton(
                  icon: const Icon(Icons.delete),
                  enableFeedback: true,
                  iconSize: 32,
                  padding: const EdgeInsets.all(0),
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    onRemove();
                  }),
            ),
            Column(
              children: [
                Text(
                  'ширина: ${result.width} витки: ${result.vitki} радиус: ${result.radius}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Площадь: ${result.ploshad.toStringAsFixed(3)}м², Длина: ${result.length.toStringAsFixed(3)}м',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
