import 'dart:ui';

import 'package:flutter/material.dart';

class Adapt {
  static MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
  static double _width = mediaQueryData.size.width;
  static double _height = mediaQueryData.size.height;
  static double _topBarH = mediaQueryData.padding.top;
  static double _botBarH = mediaQueryData.padding.bottom;
  static double _pixelRatio = mediaQueryData.devicePixelRatio;
  static var _ratio;

  static init(int? number) {
    int uiWidth = number ?? 750;
    _ratio = _width / uiWidth;
  }

  static px(number) {
    if (!(_ratio is double || _ratio is int)) {
      init(null);
    }
    return number * _ratio;
  }

  static onePx() {
    return 1 / _pixelRatio;
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
