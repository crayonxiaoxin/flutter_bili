import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili/util/adapt.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

/// 自定义沉浸式 appBar
/// [height]=0 时，可配合 [Scaffold.extendBodyBehindAppBar] 属性 true 使用，实现沉浸
class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;
  final double elevation;

  const NavigationAppBar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.transparent,
    this.height = 46,
    this.child,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    var top = Adapt.paddingTop();
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      elevation: elevation,
      systemOverlayStyle: statusStyle == StatusStyle.DARK_CONTENT
          ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: color)
          : SystemUiOverlayStyle.light.copyWith(statusBarColor: color),
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: top),
        child: child,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.zero;
}
