import 'package:flutter/material.dart';
import 'package:flutter_bili/page/favorite_page.dart';
import 'package:flutter_bili/page/home_page.dart';
import 'package:flutter_bili/page/profile_page.dart';
import 'package:flutter_bili/page/ranking_page.dart';
import 'package:flutter_bili/util/color.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), RankingPage(), FavoritePage(), ProfilePage()],
        onPageChanged: (index) {
          setState(() {
            // 控制选中的 tab
            _currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), // 禁止滑动翻页
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // 让 pageView 显示对应 tab
          _controller.jumpToPage(index);
          setState(() {
            // 控制选中的 tab
            _currentIndex = index;
          });
        },
        // 禁止上下浮动
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3)
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ));
  }
}
