import 'package:flutter/material.dart';

class ScrollableOnKeyboardScreenWrapper extends StatelessWidget {
  final Widget Function(BoxConstraints constraints) builder;
  final ScrollPhysics? physics;

  const ScrollableOnKeyboardScreenWrapper({
    required this.builder,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: physics,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: builder(constraints),
          ),
        ),
      ),
    );
  }
}
