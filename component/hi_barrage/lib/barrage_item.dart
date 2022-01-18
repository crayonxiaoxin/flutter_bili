import 'package:flutter/material.dart';

import 'barrage_transition.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged? onComplete;
  final Duration duration;

  BarrageItem(
      {Key? key,
      this.id = "",
      this.top = 0,
      required this.child,
      this.onComplete,
      this.duration = const Duration(seconds: 9)})
      : super(key: key);

  /// fix 动画状态错乱
  final _key = GlobalKey<BarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
          key: _key,
          onComplete: (value) {
            onComplete?.call(this.id);
          },
          duration: duration,
          child: child,
        ));
  }
}
