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
      required this.values})
      : super(key: key);
  final Color? color;
  final List<String> values;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final Function(String string)? onValueChanged;
  final Function()? onDown;
  final Function()? onUp;
  final bool reverse;
  final bool isEnabled;
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.6);
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
    TextStyle mytextStyle =
        textStyle ?? Theme.of(context).textTheme.bodyLarge ?? const TextStyle();

    pageController.addListener(() {
      debugPrint('page position = ${pageController.page}');
    });
    return Container(
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: _UpButton(onTap: _onUpArrow)),
          Flexible(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: width,
              height: height,
              child: Center(
                child: Consumer(builder: (context, ref, child) {
                  return PageView(
                    padEnds: true,
                    pageSnapping: true,
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
                                  final textController = TextEditingController(
                                      text: (values[index]).toString());
                                  final focusNode = FocusNode();
                                  focusNode.addListener(() {
                                    if (focusNode.hasFocus) {
                                      textController.selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset:
                                              textController.text.length);
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
                                      textController.text = textController.text
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
                                  );
                                  return isEnabled
                                      ? textField
                                      : Text(
                                          (values[index]).toString(),
                                          style: mytextStyle,
                                        );
                                }),
                              ))
                    ],
                  );
                }),
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

            // color: color ?? Colors.white,
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

            // color: color ?? Colors.white,
          )),
    );
  }
}

buttonStyle(BuildContext context) => ButtonStyle(
      elevation: MaterialStatePropertyAll(0.0),
      foregroundColor: MaterialStatePropertyAll(
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white),
      padding: MaterialStatePropertyAll(EdgeInsets.zero),
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      // fixedSize: MaterialStateProperty.all(
      // const Size.fromHeight(10),
      // ),
    );
