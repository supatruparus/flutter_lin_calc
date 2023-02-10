part of 'main_page_view.dart';

  class _Result extends StatelessWidget {
    const _Result({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Title(),
            SizedBox(height: 20,),
            _Ploshad(),
            SizedBox(height: 20,),
            _Length(),


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
      '${Strings.result}:', style: ref.watch(theme.select((value) => value.textStyle)),);
  }
}

class _Ploshad extends ConsumerWidget {
  const _Ploshad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));

    final double ploshad = ref.watch(resultProvider).ploshad;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text('${Strings.ploshad}: ', style: textStyle),
      Text('${ploshad.toStringAsFixed(3)}м²', style: textStyle,)
      ],
    );
  }
}
class _Length extends ConsumerWidget {
  const _Length({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    double dlina = ref.watch(resultProvider).length;
    TextStyle textStyle = ref.watch(theme.select((value) => value.textStyle));
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${Strings.length}: ', style: textStyle),
          Text('${dlina.toStringAsFixed(3)}м', style:  textStyle,)
        ],
      ),
    );
  }
}


