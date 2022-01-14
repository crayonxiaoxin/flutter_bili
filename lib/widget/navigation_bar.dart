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
  final Widget? leading;
  final Color? backgroundColor;
  final double elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Widget? child;

  const NavigationAppBar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.transparent,
    this.height = 46,
    this.elevation = 0,
    this.leading,
    this.backgroundColor = Colors.transparent,
    this.shadowColor,
    this.shape,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    var top = Adapt.paddingTop();
    return AppBar(
      toolbarHeight: height,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      leading: leading,
      automaticallyImplyLeading: false,
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
  Size get preferredSize => Size(Adapt.screenWidth(), height);
}
