import 'package:flutter/material.dart';

class ScrollableOnKeyboardScreenWrapper extends StatelessWidget {
  final Widget Function(BoxConstraints constraints) builder;

  const ScrollableOnKeyboardScreenWrapper({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: builder(constraints),
          ),
        ),
      ),
    );
  }
}
