import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/utils.dart';

class ScrollInputV3 extends StatefulWidget {
  const ScrollInputV3(
      {Key? key,
      this.width = 120,
      this.height = double.maxFinite,
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
      PageController(initialPage: widget.initialPage, viewportFraction: 0.5);

  int currentPage = 0;
  bool isEditMode = false;
  double? height;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _textController =
      TextEditingController(text: widget.values[widget.initialPage]);
  late List<Widget> pagesList = List.generate(
      widget.values.length,
      (index) => Center(
            child: Text(widget.values[index]),
          ));

  late Widget scrollInputTextField = ScrollInputTextField(
    controller: _textController,
    // showCursor: true,
    // textAlign: TextAlign.center,
    focusNode: _focusNode,

    decoration: const InputDecoration(
        hoverColor: Colors.transparent,
        filled: false,
        border: InputBorder.none,
        fillColor: Colors.transparent),
    onTapOutside: (event) {
      _focusNode.unfocus();
      isEditMode = false;
      setState(() {});
    },
    onValueChanged: (string) {
      if (string != '') {
        _onChanged(string);
      }
    },
    pageController: pageController,
    style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
    values: widget.values,
  );

  _onTap() {
    print('tap');
    setState(() {
      isEditMode = true;
    });
    _focusNode.requestFocus();
    _textController.text = widget.values[currentPage];
    _textController.selectAll();
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

  _onChanged(String string) {
    widget.onValueChanged?.call(string);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: _UpButton(onTap: _onUpArrow)),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Builder(builder: (context) {
                    return LayoutBuilder(builder: (context, constr) {
                      height = constr.maxHeight;

                      return PageView(
                        reverse: widget.reverse,
                        onPageChanged: (page) {
                          currentPage = page.toInt();
                          setState(() {});
                          String string = widget.values[page.toInt()];
                          widget.onValueChanged?.call(string);
                        },
                        allowImplicitScrolling: false,
                        scrollDirection: Axis.vertical,
                        controller: pageController,
                        children: pagesList,
                      );
                    });
                  }),
                ),
                Container(
                  // color: Colors.green,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onTap,
                    child: Visibility(
                        visible: isEditMode,
                        child: Center(
                          child: Container(
                            // height: (height ?? 10) * 0.55,
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
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.9),
                                    Colors.black,
                                    Colors.black.withOpacity(0.9),
                                    Colors.transparent
                                  ]),
                            ),
                            // color: Colors.black,
                            child: Center(child: scrollInputTextField),
                          ),
                        )),
                  ),
                ),
                const _ForeGround(),
              ],
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
    return Center(
      child: IgnorePointer(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
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
      ),
    );
  }
}

class ScrollInputTextField extends TextField {
  const ScrollInputTextField(
      {super.key,
      super.onTapOutside,
      super.style,
      super.textAlign = TextAlign.center,
      super.keyboardType = TextInputType.number,
      required super.focusNode,
      super.onChanged,
      super.decoration,
      required this.pageController,
      required this.onValueChanged,
      required super.controller,
      required this.values})
      : super(
            maxLines: null,
            expands: true,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlignVertical: TextAlignVertical.center);

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
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate);
      controllerText = initialText;
    }
    onValueChanged?.call(controllerText);
  }

  _onTapOutside2(PointerDownEvent event) {
    String controllerText = controller!.text;
    if (focusNode!.hasFocus) {
      // focusNode!.unfocus();
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
    super.onTapOutside?.call(event);
  }
}
