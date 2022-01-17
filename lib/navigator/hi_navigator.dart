import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili/navigator/bottom_navigator.dart';
import 'package:flutter_bili/page/dark_mode_page.dart';
import 'package:flutter_bili/page/login_page.dart';
import 'package:flutter_bili/page/notice_page.dart';
import 'package:flutter_bili/page/registration_page.dart';
import 'package:flutter_bili/page/video_detail_page.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

/// 获取 routeStatus 在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由封装，路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  notice,
  darkMode,
  unknown
}

/// 获取路由状态
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is NoticePage) {
    return RouteStatus.notice;
  }else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else {
    return RouteStatus.unknown;
  }
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

/// 监听路由页面跳转
/// 感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  HiNavigator._();

  RouteJumpListener? _routeJumpListener;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current; // 打开过的page
  RouteStatusInfo? _bottomTab; // 首页底部当前tab
  static HiNavigator? _instance;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  void exit() {
    SystemNavigator.pop(); // 退出应用
  }

  /// 首页底部 tab 切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  /// 注册路由跳转逻辑
  void registerRouteJumpListener(RouteJumpListener listener) {
    this._routeJumpListener = listener;
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map<dynamic, dynamic>? args}) {
    this._routeJumpListener?.onJumpTo?.call(routeStatus, args: args);
  }

  /// 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    // 当前的页面信息
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }
    print("hi_navigator: current: ${current.page}");
    print("hi_navigator: pre: ${_current?.page}");
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

/// 抽象类，供 HiNavigator 实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

/// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
