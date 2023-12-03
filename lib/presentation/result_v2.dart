import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../consts/strings.dart';
import '../data/result_provider.dart';
import '../data/theme_provider.dart';

class _Result extends StatelessWidget {
  const _Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const _Title(),
          const _Ploshad(),
          const _Length(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.save_rounded))
        ],
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Text(
      '${Strings.result}:',
      style: ref.watch(theme.select((value) => value.textStyle)),
    );
  }
}

class _Ploshad extends ConsumerWidget {
  const _Ploshad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));

    final double? ploshad = ref.watch(resultProvider).ploshad;
    String text = ploshad != -1 ? '${ploshad!.toStringAsFixed(3)}м²' : '--';
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${Strings.ploshad}: ', style: textStyle),
          Text(
            text,
            style: textStyle,
          )
        ],
      ),
    );
  }
}

class _Length extends ConsumerWidget {
  const _Length({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    double? dlina = ref.watch(resultProvider).length;
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));
    String text = dlina != -1 ? '${dlina!.toStringAsFixed(3)}м' : '--';
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${Strings.length}: ', style: textStyle),
          Text(
            text,
            style: textStyle,
          )
        ],
      ),
    );
  }
}
