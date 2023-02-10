import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollInput extends StatelessWidget {
  const ScrollInput(
      {Key? key,
      this.width = 120,
      this.height = 70,
      this.onPageChanged,
      this.textStyle = const TextStyle(),
        this.onUp,
      this.onDown,
      this.color = Colors.white70,
      required this.controller,
      required this.values})
      : super(key: key);
  final Color color;
  final PageController controller;
  final List<String> values;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Function(int page)? onPageChanged;
  final Function()? onDown;
  final Function()? onUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNeumorphicIcon(onTap: (){onUp?.call();
        controller.previousPage(duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);}),
        Container(
          decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(15))),
          width: width,
          height: height,
          child: Center(
            child: Consumer(builder: (context, ref, child) {
              return PageView(
                onPageChanged: (page) {
                  onPageChanged?.call(page);
                },
                allowImplicitScrolling: false,
                clipBehavior: Clip.antiAlias,
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [
                  ...List.generate(
                      values.length,
                      (index) => SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                              child: Text(
                            values[index],
                            style: textStyle,
                          ))))
                ],
              );
            }),
          ),
        ),
        RotatedBox(
            quarterTurns: 2,
            child: buildNeumorphicIcon(
              onTap: () {
                onDown?.call();
                controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);}
    )
            )
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
