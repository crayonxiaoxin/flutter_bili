import 'package:flutter/material.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/page/home_tab_page.dart';
import 'package:flutter_bili/util/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController? _controller;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "游戏", "娱乐", "音乐", "短片·手书·配音"];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("home page current: ${current.page}");
      print("home page pre: ${pre?.page}");
      if (current.page == widget || current.page is HomePage) {
        print("home page onResume!");
      } else if (pre?.page == widget || pre?.page is HomePage) {
        print("home page onPause!!!");
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          _tabBar(),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((tab) {
                    return HomeTabPage(name: tab);
                  }).toList()))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primary, width: 2.0),
          insets: EdgeInsets.only(left: 15, right: 15)),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      padding: EdgeInsets.zero,
      tabs: tabs.map((tab) {
        return Tab(
          height: 36,
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}
