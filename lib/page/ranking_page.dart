import 'package:flutter/material.dart';
import 'package:flutter_bili/page/ranking_tab_page.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:flutter_bili/widget/hi_tab.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const tabs = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];

  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavigationAppBar(
        height: 0,
        color: Colors.white,
        statusStyle: StatusStyle.DARK_CONTENT,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: _tabBar(),
          ),
          _buildTabView(),
        ],
      ),
    );
  }

  _tabBar() {
    return Container(
      alignment: Alignment.center,
      decoration: bottomBoxShadow(),
      child: HiTab(
        tabs.map((tab) {
          return Tab(
            height: 36,
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab['name'] ?? "",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList(),
        controller: _controller,
        fontSize: 16,
        unselectedLabelColor: Colors.grey[500],
      ),
    );
  }

  _buildTabView() {
    return Flexible(
        child: TabBarView(
            controller: _controller,
            children: tabs.map((tab) {
              return Container(
                child: RankingTabPage(
                  sort: tab['key']!,
                ),
              );
            }).toList()));
  }
}
