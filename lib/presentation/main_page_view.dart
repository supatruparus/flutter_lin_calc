import 'package:flutter/material.dart';
import 'package:flutter_lin_calc/utils/extensions.dart';
import 'package:flutter_lin_calc/widgets/scroll_input_v3.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(Strings.title)),
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
                      child: const _Result()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
