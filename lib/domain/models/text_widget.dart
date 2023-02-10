import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TextWidget  {
  TextWidget(this.data);
  final String data;
}

class Txt extends StatelessWidget  implements TextWidget{
  const Txt(this._data,{Key? key, this.style}) : super(key: key);
  final String _data;
  final TextStyle? style;


  @override
  Widget build(BuildContext context) {
    return Text(_data, style: style,);
  }

  @override
  // TODO: implement data
  String get data => _data;
}

class NeuText extends NeumorphicText implements TextWidget{
  NeuText(this._data, {super.key, super.style, super.textStyle, super.textAlign}) : super(_data);

    final String _data;

  @override
  // TODO: implement data
  String get data => throw UnimplementedError();

}
