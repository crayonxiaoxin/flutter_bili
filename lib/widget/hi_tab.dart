import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class HiTab extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final double fontSize;
  final Color? unselectedLabelColor;
  final double borderWidth;
  final double insets;

  const HiTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 14,
      this.unselectedLabelColor,
      this.borderWidth = 2,
      this.insets = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primary, width: borderWidth),
          insets: EdgeInsets.only(left: insets, right: insets)),
      labelStyle: TextStyle(fontSize: fontSize),
      labelColor: primary,
      unselectedLabelColor: unselectedLabelColor,
      padding: EdgeInsets.zero,
      tabs: tabs,
    );
  }
}
