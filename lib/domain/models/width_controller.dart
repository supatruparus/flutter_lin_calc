
class ScrollInputController<T> {
  ScrollInputController({this.value, this.page = 0});
  final int page;
  final T? value;
}