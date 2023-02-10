part of 'main_page_view.dart';


class _WidthSetter extends StatelessWidget {
  const _WidthSetter({
    super.key,
    required this.viewModel,
  });

  final ViewModelNotifier viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(
            builder: (context, ref, child) {
              return Text(Strings.width, style: ref.watch(theme.select((value) => value.textStyle)) ,);
            }
        ),
        Consumer(
            builder: (context, ref, child) {
              return ScrollInput(
                  values: List.generate(20, (index) => (index/2).toString()),
                  textStyle: ref.watch(theme.select((value) => value.textStyle)),
                  onPageChanged: (page){
                    double value = (page/2);
                    viewModel.onPickWidth(value);},

                  controller: viewModel.widthController);
            }
        )
      ],
    );
  }
}