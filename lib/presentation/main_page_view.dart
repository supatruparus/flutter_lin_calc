import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/utils/extensions.dart';
import 'package:flutter_lin_calc/widgets/scroll_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../consts/strings.dart';
import '../data/lin_calc_app_rep.dart';
import '../data/result_provider.dart';
import '../data/theme_provider.dart';
import '../domain/models/lin_calc_app.dart';
part 'radius_setter.dart';
part 'vitki_setter.dart';
part 'width_setter.dart';
part 'result_v2.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.read(viewModelProvider.notifier);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(Strings.title)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450, maxHeight: screenHeight),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 1, child: _WidthSetter(viewModel: viewModel)),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                // color: Colors.green.withAlpha(200),
                                width: double.maxFinite,
                                child: _VitkiSetter(viewModel: viewModel))),
                        Flexible(
                          flex: 1,
                          child: _RadiusSetter(
                            viewModel: viewModel,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(flex: 1, child: _Result()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
