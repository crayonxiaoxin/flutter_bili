import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_state.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/dao/home_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/page/home_tab_page.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/navigation_bar.dart' as NB;

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController? _controller;

  // var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "游戏", "娱乐", "音乐", "短片·手书·配音"];
  List<HomeCategory> categoryList = [];
  List<HomeBanner> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("home page current: ${current.page}");
      print("home page pre: ${pre?.page}");
      if (current.page == widget || current.page is HomePage) {
        print("home page onResume!");
      } else if (pre?.page == widget || pre?.page is HomePage) {
        print("home page onPause!!!");
      }
    });
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          NB.NavigationBar(
            height: 50,
            child: _appBar(),
            color: Colors.white,
            statusStyle: NB.StatusStyle.DARK_CONTENT,
          ),
          Container(
            color: Colors.white,
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: categoryList.map((tab) {
                    return HomeTabPage(
                      name: tab.name ?? "",
                      bannerList: bannerList,
                    );
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
      labelColor: primary,
      unselectedLabelColor: Colors.grey[500],
      padding: EdgeInsets.zero,
      tabs: categoryList.map((tab) {
        return Tab(
          height: 36,
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab.name ?? "",
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }

  void loadData() async {
    try {
      HomeEntity result = await HomeDao.get("推荐");
      print(result);
      if (result.categoryList != null) {
        setState(() {
          categoryList = result.categoryList!;
          bannerList = result.bannerList!;
          _controller = TabController(length: categoryList.length, vsync: this);
        });
      }
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: InkWell(
              borderRadius: BorderRadius.circular(23),
              onTap: () {
                widget.onJumpTo?.call(3);
              },
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("assets/images/avatar.png"),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
