part of 'main_page_view.dart';

class _Result extends ConsumerWidget {
  const _Result({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    LinCalcApp linCalcApp = ref.read(viewModelProvider.notifier);
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(flex: 1, child: _Ploshad()),
          const Flexible(flex: 1, child: _Length()),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              onPressed: () {
                linCalcApp.onSaveResult();
              },
              icon: const Icon(Icons.save_rounded),
              // iconSize: 32,
            ),
          )
        ],
      ),
    );
  }
}

class _Ploshad extends ConsumerWidget {
  const _Ploshad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));

    final double ploshad = ref.watch(resultProvider).ploshad;
    String text = ploshad != 0 ? '${ploshad.toStringAsFixed(3)}м²' : '--';
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
  const _Length();

  @override
  Widget build(BuildContext context, ref) {
    double? dlina = ref.watch(resultProvider).length;
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));
    String text = dlina != 0 ? '${dlina.toStringAsFixed(3)}м' : '--';
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${Strings.length}: ', style: textStyle),
          Text(text),
        ],
      ),
    );
  }
}
