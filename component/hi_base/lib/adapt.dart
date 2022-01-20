import 'dart:ui';

import 'package:flutter/material.dart';

/// 静态非响应式
class Adapt {
  static MediaQueryData get mediaQueryData => MediaQueryData.fromWindow(window);

  static double get _width => mediaQueryData.size.width;

  static double get _height => mediaQueryData.size.height;

  static double get _topBarH => mediaQueryData.padding.top;

  static double get _botBarH => mediaQueryData.padding.bottom;

  static double get _pixelRatio => mediaQueryData.devicePixelRatio;
  static var _ratio;

  static init(int? number) {
    int uiWidth = number ?? 750;
    _ratio = mediaQueryData.size.width / uiWidth;
  }

  static px(number) {
    if (!(_ratio is double || _ratio is int)) {
      init(null);
    }
    return number * _ratio;
  }

  static onePx() {
    return 1 / mediaQueryData.devicePixelRatio;
  }

  static screenWidth() {
    return _width;
  }

  static screenHeight() {
    return _height;
  }

  static paddingTop() {
    return _topBarH;
  }

  static paddingBottom() {
    return _botBarH;
  }
}

/// 响应式
extension AdaptiveSize on BuildContext {
  get screenWidth => MediaQuery.of(this).size.width;

  get screenHeight => MediaQuery.of(this).size.height;

  get statusBarHeight => MediaQuery.of(this).padding.top;

  get bottomNavigationHeight => MediaQuery.of(this).padding.bottom;

  double adaptive(num px, {uiWidth = 750}) {
    var ratio = screenWidth / uiWidth;
    return ratio * px;
  }
}

/// 子widget 获取 父widget 对应比例的高度
typedef AdaptiveBuilder = Widget? Function(double height);

/// 响应式 Container
Widget adaptiveContainer(
    {Widget? child, AdaptiveBuilder? builder, double aspectRatio = 16 / 9}) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      var width = constraints.maxWidth;
      var height = width / aspectRatio;
      if (builder != null) {
        child = builder.call(height);
      }
      return SizedBox(
        width: width,
        height: height,
        child: child,
      );
    },
  );
}
