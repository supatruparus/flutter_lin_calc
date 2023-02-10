

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsumerText extends ConsumerWidget {
  const ConsumerText({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final ProviderListenable<String> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(provider));
  }
}
