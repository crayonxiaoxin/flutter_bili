import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/widget/hi_banner.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<HomeBanner>? bannerList;

  const HomeTabPage({Key? key, this.name = "", this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 12),
        children: [if (widget.bannerList != null) _banner()],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: HiBanner(
        widget.bannerList,
        bannerHeight: 150,
      ),
    );
  }
}
