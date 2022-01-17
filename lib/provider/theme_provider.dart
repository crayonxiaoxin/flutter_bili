import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/db/hi_cache.dart';
import 'package:flutter_bili/util/color.dart';

import '../const.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['system', 'light', 'dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().get(Const.theme);
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
    return _themeMode;
  }

  /// 设置主题
  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(Const.theme, themeMode.value);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    // var theme = ThemeData();
    // var themeData = theme.copyWith(
    //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
    //   errorColor: isDarkMode ? HiColor.darkRed : HiColor.red,
    //   // 背景主色调
    //   primaryColor: isDarkMode ? HiColor.darkBg : Colors.white,
    //   colorScheme: theme.colorScheme.copyWith(
    //       primary: isDarkMode ? HiColor.darkBg : Colors.white,
    //       background: isDarkMode ? HiColor.darkBg : Colors.white,
    //       secondary: isDarkMode ? primary[50] : Colors.white,
    //       brightness: isDarkMode ? Brightness.dark : Brightness.light),
    //   // 指示器颜色
    //   indicatorColor: isDarkMode ? primary[50] : Colors.white,
    //   // 页面背景色
    //   scaffoldBackgroundColor: isDarkMode ? HiColor.darkBg : Colors.white,
    //   appBarTheme: null,
    // );
    // var themeData = ThemeData(
    //     colorScheme: ColorScheme.fromSwatch(
    //   primarySwatch: white,
    //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
    //   accentColor: isDarkMode ? primary[50] : Colors.white,
    //   backgroundColor: isDarkMode ? HiColor.darkBg : Colors.white,
    // ));
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
