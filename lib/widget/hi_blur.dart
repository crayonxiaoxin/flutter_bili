import 'dart:ui';

import 'package:flutter/material.dart';

/// 高斯模糊
class HiBlur extends StatelessWidget {
  final Widget? child;

  // 模糊值
  final double sigma;

  final Color color;

  const HiBlur(
      {Key? key, this.child, this.sigma = 10, this.color = Colors.white10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: color,
        child: child,
      ),
    );
  }
}
