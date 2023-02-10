part of 'main_page_view.dart';

class _RadiusSetter extends StatelessWidget {
  const _RadiusSetter({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final ViewModelNotifier viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(builder: (context, ref, child) {
          return Text(
            Strings.radius,
            style: ref.watch(theme.select((value) => value.textStyle)),
          );
        }),
        Consumer(builder: (context, ref, child) {
          return ScrollInput(
              onPageChanged: (page) {
                viewModel.onPickRadius(page/10);
              },
              values: List.generate(1000, (index) => (index / 10).toString()),
              textStyle: ref.watch(theme.select((value) => value.textStyle)),
              controller: viewModel.radiusController);
        })
      ],
    );
  }
}
