import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HiDefend {
  /// 统一异常捕获
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kReleaseMode) {
        // 线上环境
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.empty);
      } else {
        // 开发环境
        FlutterError.dumpErrorToConsole(details);
      }
    };
    // flutter 异常
    runZonedGuarded(() {
      runApp(app);
    }, (error, stack) {
      _reportError(error, stack);
    });
  }

  /// 异常上报
  void _reportError(Object error, StackTrace stack) {
    print("kReleaseMode: $kReleaseMode");
    print("统一异常捕获: $error");
  }
}
