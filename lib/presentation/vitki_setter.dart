part of 'main_page_view.dart';

class _VitkiSetter extends StatelessWidget {
  const _VitkiSetter({Key? key, required this.viewModel}) : super(key: key);
  final ViewModelNotifier viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(builder: (context, ref, child) {
          return Text(
            Strings.vitki,
            style: ref.watch(theme.select((value) => value.textStyle)),
          );
        }),
        Consumer(builder: (context, ref, child) {
          return ScrollInputV3(
            reverse: false,
            onValueChanged: (string) {
              int vitki = double.parse(string).toInt();
              viewModel.onPickVitki(vitki);
            },
            textStyle: Theme.of(context).textTheme.bodyLarge,
            values: List.generate(100, (index) => index.toString()),
          );
        })
      ],
    );
  }
}
