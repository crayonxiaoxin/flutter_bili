import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      if (kDebugMode) {
        print("hi_state: 本次 setState() 调用将不执行: ${toString()}");
      }
    }
  }
}
