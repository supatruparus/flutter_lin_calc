import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/widgets/utils/utils.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollInputV3 extends StatefulWidget {
  const ScrollInputV3(
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

  @override
  State<ScrollInputV3> createState() => _ScrollInputV3State();
}

class _ScrollInputV3State extends State<ScrollInputV3> {
  late final PageController pageController =
      PageController(initialPage: widget.initialPage, viewportFraction: 0.6);

  late List<Page> pagesList;

  _onDownArrow() {
    widget.onDown?.call();
    pageController.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  _onUpArrow() {
    widget.onUp?.call();
    pageController.previousPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  _onChanged(String string, int index) {
    widget.onValueChanged?.call(string);
  }

  @override
  Widget build(BuildContext context) {
    pagesList = List.generate(
        widget.values.length,
        (index) => Page(
            text: widget.values[index],
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (string) {
              _onChanged(string, index);
            },
            pageController: pageController,
            values: widget.values));

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
              width: widget.width,
              height: widget.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: Consumer(builder: (context, ref, child) {
                      return PageView(
                        reverse: widget.reverse,
                        onPageChanged: (page) {
                          String string = widget.values[page.toInt()];
                          widget.onValueChanged?.call(string);
                        },
                        allowImplicitScrolling: false,
                        scrollDirection: Axis.vertical,
                        controller: pageController,
                        children: pagesList,
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

ButtonStyle buttonStyle(BuildContext context) => ButtonStyle(
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

class ScrollInputTextField extends TextField {
  const ScrollInputTextField(
      {super.key,
      super.onTapOutside,
      super.style,
      super.showCursor = true,
      super.textAlign = TextAlign.center,
      super.keyboardType = TextInputType.number,
      super.decoration,
      super.enabled,
      super.strutStyle = StrutStyle.disabled,
      required super.focusNode,
      super.onChanged,
      required this.pageController,
      super.enableInteractiveSelection = false,
      super.selectionHeightStyle = BoxHeightStyle.tight,
      required this.onValueChanged,
      required super.controller,
      required this.values});

  final Function(String string)? onValueChanged;

  final List<String> values;
  final PageController pageController;

  @override
  TapRegionCallback? get onTapOutside => _onTapOutside2;

  @override
  ValueChanged<String>? get onChanged => _onChanged;

  _onChanged(String string) {
    final String initialText = string;
    controller!.formatLastInput();
    String controllerText = controller!.text;
    if (controllerText != '') {
      int page =
          values.indexOf(double.parse(controllerText).toInt().toString());

      pageController.animateToPage(page,
          duration: Duration(milliseconds: 100), curve: Curves.decelerate);
      controllerText = initialText;
    }
    onValueChanged?.call(controllerText);
  }

  _onTapOutside2(PointerDownEvent event) {
    String controllerText = controller!.text;
    if (focusNode!.hasFocus) {
      focusNode!.unfocus();
      if (controllerText != '') {
        int page = values.indexOf(double.parse(controllerText).toString());
        if (page != -1) {
          pageController.jumpToPage(page);
        } else {
          page =
              values.indexOf(double.parse(controllerText).toInt().toString());
          pageController.jumpToPage(page);
        }
      }
    }
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
    required this.text,
    this.style,
    required this.onChanged,
    required this.pageController,
    required this.values,
  });
  final String text;
  final TextStyle? style;
  final PageController pageController;
  final List<String> values;
  final Function(String string) onChanged;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (context) {
        final controller = TextEditingController(text: text);
        final focusNode = FocusNode();
        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            controller.selectAll();
          }
        });

        return ScrollInputTextField(
          focusNode: focusNode,
          decoration: const InputDecoration(
              border: InputBorder.none,
              enabled: true,
              floatingLabelAlignment: FloatingLabelAlignment.center),
          controller: controller,
          style: style,
          onValueChanged: (String string) {
            onChanged.call(string);
          },
          pageController: pageController,
          values: values,
        );
      }),
    );
  }
}
