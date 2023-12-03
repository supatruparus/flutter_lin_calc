import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/data/result_provider.dart';
import 'package:flutter_lin_calc/presentation/result_v2.dart';
import 'package:flutter_lin_calc/utils/extensions.dart';
import 'package:flutter_lin_calc/widgets/scroll_input_v3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../consts/strings.dart';
import '../data/page_view_model_provider.dart';
import '../data/theme_provider.dart';

part 'radius_setter.dart';

part 'result.dart';

part 'vitki_setter.dart';

part 'width_setter.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.read(viewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                          child: Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            Strings.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: ref.read(theme).textStyle.copyWith(
                                  fontSize: 40,
                                ),
                          ),
                        ),
                      )),
                      _WidthSetter(viewModel: viewModel),
                      _VitkiSetter(viewModel: viewModel),
                      _RadiusSetter(
                        viewModel: viewModel,
                      ),
                    ],
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                          minHeight: 200, minWidth: double.infinity),
                      child: const ResultV2()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
