import 'package:flutter/material.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:flutter_bili/http/request/notice_request.dart';
import 'package:flutter_bili/model/video_model.dart';
import 'package:flutter_bili/page/home_page.dart';
import 'package:flutter_bili/page/login_page.dart';
import 'package:flutter_bili/page/registration_page.dart';
import 'package:flutter_bili/page/video_detail_page.dart';
import 'package:flutter_bili/util/color.dart';

import 'db/hi_cache.dart';
import 'navigator/hi_navigator.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouterDelegate _routerDelegate = BiliRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HiCache.preInit(), // 初始化 cache
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routerDelegate) // cache 初始化完成
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(), // 显示 loading
                  ),
                );
          return MaterialApp(
              home: widget,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: white,
              ));
        });
    // return MaterialApp(
    //   home: widget,
    // );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home: RegistrationPage(),
      // home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(onJump2Register: () {
              Navigator.pushNamed(context, '/register');
            }),
        '/login': (context) => LoginPage(onJump2Register: () {
              Navigator.pushNamed(context, '/register');
            }),
        '/register': (context) => RegistrationPage(
              onJump2Login: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    // var request = TestRequest();
    // request
    //     .addParam("aa", "ddd")
    //     .addParam("bb", "333")
    //     .addParam("requestPrams", "abc");
    // var result = await HiNet.getInstance().fire(request);
    // print(result);
    // test2();
    // testLogin();
    testNotice();
    setState(() {
      _counter++;
    });
  }

  void test2() {
    HiCache.getInstance().setString("bb", "hello");
    var value = HiCache.getInstance().get("bb");
    print(value);
  }

  void testLogin() async {
    try {
      // var result = LoginDao.register("123", "password", "123333", "1234");
      var result = await LoginDao.login("111", "111");
      print("test: " + result);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void testNotice() async {
    try {
      var request = NoticeRequest();
      request.addParam("pageIndex", 0).addParam("pageSize", 10);
      var result = await HiNet.getInstance().fire(request);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BiliRouterDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  GlobalKey<NavigatorState>? navigatorKey;

  BiliRouterDelegate() : this.navigatorKey = GlobalKey<NavigatorState>();
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    // 管理路由堆栈
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tmpPages = pages;
    if (index != -1) {
      // 要打开的页面已经存在，则将该页面和它之上的所有页面都出栈，即不保留当前页面及其之后的页面
      tmpPages = tmpPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 首页，所有前面的页面都出栈
      tmpPages.clear();
      page = pageWrap(HomePage(
        onJump2Detail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.detail && videoModel != null) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage(
        onSuccess: () {
          _routeStatus = RouteStatus.home;
          notifyListeners();
        },
        onJump2Register: () {
          _routeStatus = RouteStatus.registration;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(
        onJump2Login: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    }
    if (page != null) {
      tmpPages = [...tmpPages, page]; // 添加当前页面
    }
    pages = tmpPages;
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            // 在这里控制是否可以返回
            if (!route.didPop(result)) {
              return false;
            } else {
              return true;
            }
          },
        ),
        // fix Android 物理返回键，无法返回上一页的问题
        onWillPop: () async {
          // true -不拦截物理返回键， false -处理 flutter 的回退逻辑
          return !(await navigatorKey?.currentState?.maybePop() ?? false);
        });
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

/// 定义路由数据，path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
