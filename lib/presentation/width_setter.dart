part of 'main_page_view.dart';


class _WidthSetter extends StatelessWidget {
  const _WidthSetter({
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
              return ScrollInputV3(
                isEnabled: false,
                  values: List.generate(20, (index) => (index/2).toString()),
                  textStyle: ref.watch(theme.select((value) => value.textStyle)),
                  onValueChanged: (string){
                    double width = double.parse(string);
                    viewModel.onPickWidth(width);},

                  controller: viewModel.widthController);
            }
        )
      ],
    );
  }
}