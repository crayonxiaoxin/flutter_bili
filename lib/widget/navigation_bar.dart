import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili/util/adapt.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    var top = Adapt.paddingTop();
    // return Container(
    //   width: Adapt.screenWidth(),
    //   height: top + height,
    //   child: child,
    //   padding: EdgeInsets.only(top: top),
    //   decoration: BoxDecoration(color: color),
    // );
    return AppBar(
      toolbarHeight: height,
      elevation: 0,
      systemOverlayStyle: statusStyle == StatusStyle.DARK_CONTENT
          ? SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent),
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: top),
        child: child,
      ),
    );
  }
}
