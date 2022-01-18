import 'package:flutter/material.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:hi_base/color.dart';
import 'package:provider/src/provider.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _items = [
    {"name": "跟随系统", "mode": ThemeMode.system},
    {"name": "开启", "mode": ThemeMode.dark},
    {"name": "关闭", "mode": ThemeMode.light},
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: NavigationAppBar(
        elevation: 2,
        height: 40,
        shadowColor: themeProvider.isDarkMode() ? null : Color(0x49eeeeee),
        color: themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
        statusStyle: themeProvider.isDarkMode()
            ? StatusStyle.LIGHT_CONTENT
            : StatusStyle.DARK_CONTENT,
        leading: BackButton(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
              alignment: Alignment.center,
              child: Text(
                "夜间模式",
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Positioned(left: 0, child: BackButton())
          ],
        ),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index, themeProvider);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: _items.length),
    );
  }

  Widget _item(int index, ThemeProvider themeProvider) {
    var theme = _items[index];
    var currentTheme = themeProvider.getThemeMode();
    return InkWell(
      onTap: () {
        themeProvider.setTheme(theme['mode'] as ThemeMode);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(child: Text("${theme['name']}")),
            Opacity(
              opacity: currentTheme == theme['mode'] ? 1.0 : 0.0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
