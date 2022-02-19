import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChangeNotifier<T extends ChangeNotifier> extends StatelessWidget {

  final T value;
  final Widget Function(BuildContext ctx, T prov, Widget? widget) builder;

  const CustomChangeNotifier({required this.value, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: value,
      child: Consumer<T>(
        builder: builder,
      ),
    );
  }
}
