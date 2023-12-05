import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollInputV3 extends StatelessWidget {
  ScrollInputV3(
      {Key? key,
      this.width = 120,
      this.height = 70,
      this.onValueChanged,
      this.textStyle,
      this.onUp,
      this.onDown,
      this.isEnabled = true,
      this.color,
      this.reverse = false,
      this.initialPage = 0,
      required this.values})
      : super(key: key);
  final Color? color;
  final int initialPage;
  final List<String> values;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final Function(String string)? onValueChanged;
  final Function()? onDown;
  final Function()? onUp;
  final bool reverse;
  final bool isEnabled;
  late final PageController pageController =
      PageController(initialPage: initialPage, viewportFraction: 0.6);
  final textController = TextEditingController();
  final focusNode = FocusNode();

  _onPageChanged(int page) {
    String string = values[page.toInt()];
    onValueChanged?.call(string);
  }

  _onValueChanged(String string) {
    onValueChanged?.call(string);
  }

  _onSubmit() {}

  _onTapOutside() {
    textController.text = textController.text.replaceAll(',', '.');
    String textfieldText = textController.text;
    if (focusNode.hasFocus) {
      focusNode.unfocus();
      if (textfieldText != '') {
        int page = values.indexOf(double.parse(textfieldText).toString());
        if (page != -1) {
          pageController.jumpToPage(page);
        } else {
          page = values.indexOf(double.parse(textfieldText).toInt().toString());
          pageController.jumpToPage(page);
        }
      }
    }
  }

  _onDownArrow() {
    onDown?.call();
    pageController.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  _onUpArrow() {
    onUp?.call();
    pageController.previousPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        textController.selection = TextSelection(
            baseOffset: 0, extentOffset: textController.text.length);
      }
    });
    TextStyle mytextStyle =
        TextStyle(fontSize: 32, color: Theme.of(context).colorScheme.primary);

    return SizedBox(
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: _UpButton(onTap: _onUpArrow)),
          Flexible(
            flex: 3,
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: Consumer(builder: (context, ref, child) {
                      return PageView(
                        reverse: reverse,
                        onPageChanged: (page) {
                          String string = values[page.toInt()];
                          onValueChanged?.call(string);
                        },
                        allowImplicitScrolling: false,
                        scrollDirection: Axis.vertical,
                        controller: pageController,
                        children: [
                          ...List.generate(
                              values.length,
                              (index) => Center(
                                    child: Builder(builder: (context) {
                                      final textController =
                                          TextEditingController(
                                              text: (values[index]).toString());
                                      final focusNode = FocusNode();
                                      focusNode.addListener(() {
                                        if (focusNode.hasFocus) {
                                          textController.selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: textController
                                                      .text.length);
                                        }
                                      });

                                      return TextField(
                                        showCursor: false,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            enabled: isEnabled,
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center),
                                        onChanged: (string) {
                                          onValueChanged?.call(string);
                                        },
                                        onTapOutside: (event) {
                                          textController.text = textController
                                              .text
                                              .replaceAll(',', '.');
                                          String textfieldText =
                                              textController.text;
                                          if (focusNode.hasFocus) {
                                            focusNode.unfocus();
                                            if (textfieldText != '') {
                                              int page = values.indexOf(
                                                  double.parse(textfieldText)
                                                      .toString());
                                              if (page != -1) {
                                                pageController.jumpToPage(page);
                                              } else {
                                                page = values.indexOf(
                                                    double.parse(textfieldText)
                                                        .toInt()
                                                        .toString());
                                                pageController.jumpToPage(page);
                                              }
                                            }
                                          }
                                        },
                                        controller: textController,
                                        style: mytextStyle,
                                        enableInteractiveSelection: false,
                                        selectionHeightStyle:
                                            BoxHeightStyle.tight,
                                      );
                                    }),
                                  ))
                        ],
                      );
                    }),
                  ),
                  const _ForeGround(),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 1,
              // width: double.infinity,

              child: _DownButton(onTap: _onDownArrow))
        ],
      ),
    );
  }
}

class _UpButton extends StatelessWidget {
  const _UpButton({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ElevatedButton(
          style: buttonStyle(context),
          onPressed: onTap,
          child: const Icon(
            Icons.arrow_drop_up_outlined,
          )),
    );
  }
}

class _DownButton extends StatelessWidget {
  const _DownButton({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ElevatedButton(
          style: buttonStyle(context),
          onPressed: onTap,
          child: const Icon(
            Icons.arrow_drop_down_outlined,
          )),
    );
  }
}

buttonStyle(BuildContext context) => ButtonStyle(
      elevation: const MaterialStatePropertyAll(0.0),
      foregroundColor: MaterialStatePropertyAll(
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    );

class _ForeGround extends StatelessWidget {
  const _ForeGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                transform: const GradientRotation(1.57079633),
                stops: const [
                  0.2,
                  0.3,
                  0.5,
                  0.7,
                  0.8
                ],
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.9)
                ]),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}
