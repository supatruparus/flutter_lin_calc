import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollInputV3 extends StatelessWidget {
  const ScrollInputV3(
      {Key? key,
      this.width = 120,
      this.height = 70,
      this.onValueChanged,
      this.textStyle = const TextStyle(),
      this.onUp,
      this.onDown,
      this.isEnabled = true,
      this.color = Colors.white70,
      this.reverse = false,
      required this.controller,
      required this.values})
      : super(key: key);
  final Color color;
  final PageController controller;
  final List<String> values;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Function(String string)? onValueChanged;
  final Function()? onDown;
  final Function()? onUp;
  final bool reverse;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNeumorphicIcon(onTap: () {
          onUp?.call();
          controller.previousPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut);
        }),
        Container(
          decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          width: width,
          height: height,
          child: Center(
            child: Consumer(builder: (context, ref, child) {
              return PageView(
                reverse: reverse,
                onPageChanged: (page) {
                  String string = values[page.toInt()];
                  onValueChanged?.call(string);
                },
                allowImplicitScrolling: false,
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [
                  ...List.generate(
                      values.length,
                      (index) => Center(
                        child: Builder(builder: (context) {
                          final textController = TextEditingController(
                              text: (values[index]).toString());
                          final focusNode = FocusNode();
                          focusNode.addListener(() {
                            if (focusNode.hasFocus) {
                              textController.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: textController.text.length);
                            }
                          });

                          var textField = TextField(
                            showCursor: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (string) {
                              onValueChanged?.call(string);
                            },
                            onTapOutside: (event) {
                              textController.text =
                                  textController.text.replaceAll(',', '.');
                              String textfieldText = textController.text;
                              if (focusNode.hasFocus) {
                                focusNode.unfocus();
                                if (textfieldText != '') {
                                  print(
                                      'value: ${double.parse(textfieldText)}');
                                  print(values);
                                  int page = values.indexOf(
                                      double.parse(textfieldText)
                                          .toString());
                                  if (page != -1) {
                                    print('page: $page');
                                    controller.jumpToPage(page);
                                  } else {
                                    page = values.indexOf(
                                        double.parse(textfieldText)
                                            .toInt()
                                            .toString());
                                    controller.jumpToPage(page);
                                  }
                                }
                              }
                            },
                            controller: textController,
                            style: textStyle,
                          );
                          return isEnabled
                              ? textField
                              : Text(
                                  (values[index]).toString(),
                                  style: textStyle,
                                );
                        }),
                      ))
                ],
              );
            }),
          ),
        ),
        RotatedBox(
            quarterTurns: 2,
            child: buildNeumorphicIcon(onTap: () {
              onDown?.call();
              controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut);
            }))
      ],
    );
  }

  Widget buildNeumorphicIcon({required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Icon(
        Icons.arrow_drop_up_outlined,
        size: 40,
        color: textStyle.color,
      ),
    );
  }
}
