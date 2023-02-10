import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/data/radius_provider.dart';
import 'package:flutter_lin_calc/widgets/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollInputV2 extends StatelessWidget {
  const ScrollInputV2({Key? key,
    this.width = 120,
    this.height = 70,
    this.textStyle = const TextStyle(), required this.onUp, required this.onDown, this.color = Colors.white70, required this.controller, required this.values}) : super(key: key);
  final Function() onUp;
  final Function() onDown;
  final Color color;
  final PageController controller;
  final List<String> values;
  final TextStyle textStyle;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onUp, icon: Icon(Icons.arrow_drop_up_outlined, color:color) ,),
        Container(
          decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          width: width,
          height: height,
          child: Center(
            child: Consumer(
                builder: (context, ref, child) {
                  final textController = TextEditingController();
                  return PageView(
                    allowImplicitScrolling: false,
                    clipBehavior: Clip.antiAlias,
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    children: [

                      ...List.generate(values.length, (index) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: Builder(
                            builder: (context) {
                              final textController = TextEditingController(text: (index/10).toString());
                              final focusNode = FocusNode();
                              focusNode.addListener(() {
                                if(focusNode.hasFocus){
                                  textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.text.length);
                                }
                              });

                              return TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    ),
                                onTapOutside: (event){
                                  focusNode.unfocus();
                                },
                                controller: textController, style: textStyle,);
                            }
                          ))))
                    ],
                  );
                }
            ),
          ),
        ),
        RotatedBox(quarterTurns: 2,child: IconButton(onPressed: onDown, icon: Consumer(
            builder: (context, ref, child) {
              return Icon(Icons.arrow_drop_up_outlined, color: color,);
            }
        ),))
      ],
    );
  }
}

