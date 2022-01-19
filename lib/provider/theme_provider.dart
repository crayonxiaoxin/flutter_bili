import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hi_base/color.dart';
import 'package:hi_cache/hi_cache.dart';

import '../const.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['system', 'light', 'dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  var _platformBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  /// 系统 dark mode 发生变化
  void systemDarkModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

  /// 是否是暗黑模式
  bool isDarkMode() {
    if (_themeMode == null) {
      _themeMode = getThemeMode();
    }
    if (_themeMode == ThemeMode.system) {
      // 获取系统的 dark mode
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  /// 获取主题模式
  ThemeMode getThemeMode() {
    // 修复 release 下，因 null safety 导致的 android 白屏的问题
    // String theme = HiCache.getInstance().get(Const.theme);
    String? theme = HiCache.getInstance().get(Const.theme);
    switch (theme) {
      case "dark":
        _themeMode = ThemeMode.dark;
        break;
      case "light":
        _themeMode = ThemeMode.light;
        break;
      case "system":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  /// 设置主题
  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(Const.theme, themeMode.value);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        // 背景主色调
        primaryColor: isDarkMode ? HiColor.darkBg : Colors.white,
        // 指示器颜色
        indicatorColor: isDarkMode ? primary[50] : Colors.white,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? HiColor.darkBg : Colors.white,
        colorScheme: ColorScheme(
            primary: white,
            primaryVariant: isDarkMode ? HiColor.darkBg : white,
            secondary: isDarkMode ? primary[50]! : Colors.white,
            secondaryVariant: isDarkMode ? primary[50]! : Colors.white,
            // surface: isDarkMode ? Colors.grey[800]! : Colors.white,
            surface: isDarkMode ? HiColor.darkBg : Colors.white,
            background: isDarkMode ? HiColor.darkBg : Colors.white,
            error: isDarkMode ? HiColor.darkRed : HiColor.red,
            onPrimary: isDarkMode ? Colors.white : HiColor.darkBg,
            onSecondary: isDarkMode ? Colors.white : HiColor.darkBg,
            onSurface: isDarkMode ? Colors.white : HiColor.darkBg,
            onBackground: isDarkMode ? Colors.white : HiColor.darkBg,
            onError: isDarkMode ? HiColor.darkBg : Colors.white,
            brightness: isDarkMode ? Brightness.dark : Brightness.light));

    return themeData;
  }
}
