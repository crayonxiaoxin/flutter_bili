import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_state.dart';
import 'package:flutter_bili/http/dao/home_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/page/home_tab_page.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:flutter_bili/widget/hi_tab.dart';
import 'package:flutter_bili/widget/loading_container.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;
  TabController? _controller;
  bool _isLoading = true;

  // var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "游戏", "娱乐", "音乐", "短片·手书·配音"];
  List<HomeCategory> categoryList = [];
  List<HomeBanner> bannerList = [];

  @override
  void initState() {
    super.initState();
    // 监听生命周期
    WidgetsBinding.instance?.addObserver(this);
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
    WidgetsBinding.instance?.removeObserver(this);
    HiNavigator.getInstance().removeListener(listener);
    _controller?.dispose();
    super.dispose();
  }

  /// 监听生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState: $state");
  }

  /// 监听系统暗黑模式变化
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    context.read<ThemeProvider>().systemDarkModeChange();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            NavigationAppBar(
              height: 50,
              child: _appBar(),
              color: themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
              statusStyle: themeProvider.isDarkMode()
                  ? StatusStyle.LIGHT_CONTENT
                  : StatusStyle.DARK_CONTENT,
            ),
            Container(
              decoration: bottomBoxShadow(
                  color: themeProvider.isDarkMode()
                      ? HiColor.darkBg
                      : Colors.white,
                  shadowColor:
                      themeProvider.isDarkMode() ? HiColor.darkBg : null),
              child: _tabBar(),
            ),
            Flexible(
                child: TabBarView(
                    controller: _controller,
                    children: categoryList.map((tab) {
                      return HomeTabPage(
                        categoryName: tab.name ?? "",
                        bannerList: tab.name == "推荐" ? bannerList : null,
                      );
                    }).toList()))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return HiTab(
      categoryList.map((tab) {
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
      controller: _controller,
      fontSize: 16,
      unselectedLabelColor: Colors.grey[500],
    );
    // return TabBar(
    //   controller: _controller,
    //   isScrollable: true,
    //   indicator: UnderlineTabIndicator(
    //       borderSide: BorderSide(color: primary, width: 2.0),
    //       insets: EdgeInsets.only(left: 15, right: 15)),
    //   labelColor: primary,
    //   unselectedLabelColor: Colors.grey[500],
    //   padding: EdgeInsets.zero,
    //   tabs: categoryList.map((tab) {
    //     return Tab(
    //       height: 36,
    //       child: Padding(
    //         padding: EdgeInsets.only(left: 5, right: 5),
    //         child: Text(
    //           tab.name ?? "",
    //           style: TextStyle(fontSize: 16),
    //         ),
    //       ),
    //     );
    //   }).toList(),
    // );
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
          _isLoading = false;
        });
      }
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Container(
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
          InkWell(
            onTap: () {
              // var provider = context.read<ThemeProvider>();
              // if (provider.isDarkMode()) {
              //   provider.setTheme(ThemeMode.light);
              // } else {
              //   provider.setTheme(ThemeMode.dark);
              // }
              _mockException();
            },
            child: Icon(
              Icons.explore_outlined,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.notice);
              },
              child: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 异常捕获
  void _mockException() async {
    // try catch 捕获同步异常
    try {
      throw StateError("This is a sync error.");
    } catch (e) {
      print(e);
    }
    // catchError 捕获异步异常
    Future.delayed(Duration(seconds: 1))
        .then((value) => throw StateError("This is a async error."))
        .catchError((e) {
      print(e);
    });
    // 异步转同步 try catch 捕获异常
    try {
      await Future.delayed(Duration(seconds: 1))
          .then((value) => throw StateError("This is the second async error."));
    } catch (e) {
      print(e);
    }
    // runZonedGuarded 捕获 代码块 异常
    runZonedGuarded(() {
      // throw StateError("runZonedGuarded: This is a sync error.");
      Future.delayed(Duration(seconds: 1)).then((value) =>
          throw StateError("runZonedGuarded: This is the second async error."));
    }, (Object error, StackTrace stack) {
      print(error);
    });
    // 测试统一捕获异常
    throw StateError("------测试统一捕获异常.");
  }
}
