import 'package:flutter/material.dart';
import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/bottom_navigator.dart';
import 'package:flutter_bili/page/login_page.dart';
import 'package:flutter_bili/page/registration_page.dart';
import 'package:flutter_bili/page/video_detail_page.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/toast.dart';

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

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: white,
//       ),
//       // home: MyHomePage(title: 'Flutter Demo Home Page'),
//       // home: RegistrationPage(),
//       // home: LoginPage(),
//       routes: <String, WidgetBuilder>{
//         '/': (context) => LoginPage(onJump2Register: () {
//               Navigator.pushNamed(context, '/register');
//             }),
//         '/login': (context) => LoginPage(onJump2Register: () {
//               Navigator.pushNamed(context, '/register');
//             }),
//         '/register': (context) => RegistrationPage(
//               onJump2Login: () {
//                 Navigator.pushNamed(context, '/login');
//               },
//             ),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() async {
//     // var request = TestRequest();
//     // request
//     //     .addParam("aa", "ddd")
//     //     .addParam("bb", "333")
//     //     .addParam("requestPrams", "abc");
//     // var result = await HiNet.getInstance().fire(request);
//     // print(result);
//     // test2();
//     // testLogin();
//     testNotice();
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void test2() {
//     HiCache.getInstance().setString("bb", "hello");
//     var value = HiCache.getInstance().get("bb");
//     print(value);
//   }
//
//   void testLogin() async {
//     try {
//       // var result = LoginDao.register("123", "password", "123333", "1234");
//       var result = await LoginDao.login("111", "111");
//       print("test: " + result);
//     } on NeedAuth catch (e) {
//       print(e);
//     } on NeedLogin catch (e) {
//       print(e);
//     } on HiNetError catch (e) {
//       print(e);
//     }
//   }
//
//   void testNotice() async {
//     try {
//       var request = NoticeRequest();
//       request.addParam("pageIndex", 0).addParam("pageSize", 10);
//       var result = await HiNet.getInstance().fire(request);
//       print(result);
//     } on NeedAuth catch (e) {
//       print(e);
//     } on NeedLogin catch (e) {
//       print(e);
//     } on HiNetError catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class BiliRouterDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  GlobalKey<NavigatorState>? navigatorKey;

  BiliRouterDelegate() : this.navigatorKey = GlobalKey<NavigatorState>() {
    // 实现跳转逻辑
    HiNavigator.getInstance().registerRouteJumpListener(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        if (args != null) {
          this.videoModel = args['videoMo'];
          print("args: $args");
        }
      }
      notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  HomeVideo? videoModel;

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
      // page = pageWrap(HomePage());
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail && videoModel != null) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    }
    if (page != null) {
      tmpPages = [...tmpPages, page]; // 添加当前页面
    }
    // 通知路由发生变化
    HiNavigator.getInstance().notify(tmpPages, pages);
    pages = tmpPages;
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            print("pop $result");
            // 如果登录页面之前还有其他页面，如果未登录，则阻断返回
            // 如果只有一个页面，onWillPop 就会返回桌面，此时 onPopPage 就不会执行了
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast("请先登录");
                  return false;
                }
              }
            }
            // 在这里控制是否可以返回
            if (!route.didPop(result)) {
              return false;
            } else {
              // 通知路由发生变化
              var tmpPages = [...pages];
              pages.removeLast();
              HiNavigator.getInstance().notify(pages, tmpPages);
              return true;
            }
          },
        ),
        // fix Android 物理返回键，无法返回上一页的问题
        onWillPop: () async {
          print("appbar back press 1");
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
