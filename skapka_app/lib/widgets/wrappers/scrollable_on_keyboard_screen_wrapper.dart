import 'package:flutter/material.dart';

class ScrollableOnKeyboardScreenWrapper extends StatelessWidget {
  final Widget Function(BoxConstraints constraints) builder;
  final ScrollPhysics? physics;
  final double topPadding;

  const ScrollableOnKeyboardScreenWrapper({
    required this.builder,
    this.physics,
    this.topPadding = 0.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: physics,
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - topPadding,
            ),
            child: builder(constraints),
          ),
        ),
      ),
    );
  }
}
