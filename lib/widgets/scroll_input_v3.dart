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

  int _currentPage = 0;

  late List<Widget> pagesList = List.generate(
    widget.values.length,
    (index) {
      int currentPage = _currentPage;
      return _ScrollPage(
          key: ValueKey(index),
          currentPage: currentPage,
          isActive: true,
          text: widget.values[index],
          onChanged: (string) {
            String textfieldText = string.replaceAll(',', '.');
            int page =
                widget.values.indexOf(double.parse(textfieldText).toString());
            if (page != -1) {
              pageController.jumpToPage(page);
            }
            widget.onValueChanged?.call(textfieldText);
          },
          index: index);
    },
  );

  _onPageChanged(int page) {
    String string = widget.values[page.toInt()];
    setState(() {
      _currentPage = page.toInt();
    });
    widget.onValueChanged?.call(string);
    print('currPage = $_currentPage');
  }

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

  /// Widget build
  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    child: Center(
                      child: Consumer(builder: (context, ref, child) {
                        return PageView(
                          reverse: widget.reverse,
                          onPageChanged: _onPageChanged,
                          allowImplicitScrolling: false,
                          scrollDirection: Axis.vertical,
                          controller: pageController,
                          children: List.of(pagesList),
                        );
                      }),
                    ),
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

class _ScrollPage extends StatelessWidget {
  const _ScrollPage(
      {Key? key,
      required this.isActive,
      required this.text,
      required this.onChanged,
      required this.currentPage,
      required this.index})
      : super(key: key);
  final bool isActive;
  final int currentPage;
  final Function(String string) onChanged;
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final textController = TextEditingController(text: text);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        textController.selectAll();
      }
    });
    return TextField(
      showCursor: false,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabled: isActive,
          floatingLabelAlignment: FloatingLabelAlignment.center),
      onChanged: (string) {
        if (focusNode.hasFocus) {
          if (string != '') {
            onChanged(string);
          }
        }
      },
      enabled: isActive,
      controller: textController,
      style:
          TextStyle(fontSize: 32, color: Theme.of(context).colorScheme.primary),
      enableInteractiveSelection: false,
      selectionHeightStyle: BoxHeightStyle.tight,
    );
  }
}
