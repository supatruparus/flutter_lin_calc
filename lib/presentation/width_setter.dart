part of 'main_page_view.dart';

class _WidthSetter extends StatelessWidget {
  const _WidthSetter({
    required this.viewModel,
  });

  final LinCalcAppNotifier viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(builder: (context, ref, child) {
          return Text(
            Strings.width,
            style: ref.watch(theme.select((value) => value.textStyle)),
          );
        }),
        Consumer(builder: (context, ref, child) {
          return ScrollInputV3(
            isEnabled: false,
            initialPage: (viewModel.rulonParams.width * 2).toInt(),
            values: List.generate(20, (index) => (index / 2).toString()),
            onValueChanged: (string) {
              double width = double.parse(string);
              viewModel.onPickWidth(width);
            },
          );
        })
      ],
    );
  }
}
