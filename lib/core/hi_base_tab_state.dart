import 'package:flutter/material.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:hi_base/hi_state.dart';
import 'package:hi_net/core/hi_error.dart';

/// 通用底层带分页和刷新的页面框架
/// M - Dao 返回的数据模型
/// L - 列表数据模式
/// T - 具体 widget
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  ScrollController scrollController = ScrollController();
  bool loading = false;

  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // 距离列表底部相差的距离
      var delta = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      print("distance: $delta");
      if (delta < 300 && scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  get extendBodyBehindAppBar => false;

  PreferredSizeWidget? get appBar => null;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var child = RefreshIndicator(
      onRefresh: loadData,
      color: primary,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: contentChild,
      ),
    );
    return appBar != null
        ? Scaffold(
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            appBar: appBar,
            body: child,
          )
        : child;
    // return RefreshIndicator(
    //   onRefresh: loadData,
    //   color: primary,
    //   child: MediaQuery.removePadding(
    //     removeTop: true,
    //     context: context,
    //     child: contentChild,
    //   ),
    // );
  }

  Future<M> getData(int pageIndex);

  List<L> parseList(M result);

  Future<void> loadData({bool loadMore = false}) async {
    if (!loading) {
      if (!loadMore) {
        pageIndex = 1;
      }
      var currentIndex = pageIndex + (loadMore ? 1 : 0);
      print("currentPage:$currentIndex");
      loading = true;
      try {
        var result = await getData(currentIndex);
        print(result);
        setState(() {
          if (loadMore) {
            dataList = [...dataList, ...parseList(result)];
            if (parseList(result).length > 0) {
              pageIndex++;
            }
          } else {
            dataList = parseList(result);
          }
        });
        print("base data list: $dataList");
        Future.delayed(Duration(microseconds: 1000), () {
          loading = false;
        });
      } on NeedLogin catch (e) {
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
        showWarnToast(e.message);
        loading = false;
      } on NeedAuth catch (e) {
        showWarnToast(e.message);
        loading = false;
      } on HiNetError catch (e) {
        showWarnToast(e.message);
        loading = false;
      }
    } else {
      print("上次加载还没结束。。。");
    }
  }

  @override
  bool get wantKeepAlive => true;
}
