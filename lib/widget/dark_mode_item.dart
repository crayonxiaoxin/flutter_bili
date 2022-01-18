import 'package:flutter/material.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:provider/src/provider.dart';

class DarkModeItem extends StatelessWidget {
  const DarkModeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "夜间模式",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 2),
              child: Icon(themeProvider.isDarkMode()
                  ? Icons.nightlight
                  : Icons.light_mode),
            )
          ],
        ),
      ),
    );
  }
}
