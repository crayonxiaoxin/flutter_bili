import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_state.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/dao/home_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/hi_banner.dart';
import 'package:flutter_bili/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<HomeBanner>? bannerList;

  const HomeTabPage({Key? key, this.categoryName = "", this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<HomeVideo> videoList = [];
  int pageIndex = 1;
  ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // 距离列表底部相差的距离
      var delta = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      print("distance: $delta");
      if (delta < 300) {
        _loadData(loadMore: true);
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _loadData,
      color: primary,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          // 当列表内容不足撑开屏幕时，防止下拉刷新和上拉加载失效，在android上可以下拉刷新，但依然不能上拉加载
          physics: const AlwaysScrollableScrollPhysics(),
          // 列表滚动监听
          controller: _scrollController,
          padding: EdgeInsets.only(left: 8, right: 8),
          children: [
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              axisDirection: AxisDirection.down,
              children: [
                if (widget.bannerList != null)
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: _banner(),
                      )),
                ...videoList.map((e) {
                  return StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: VideoCard(e));
                }).toList()
              ],
            )
          ],
        ),
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: HiBanner(
        widget.bannerList,
        bannerHeight: 150,
      ),
    );
  }

  Future<void> _loadData({bool loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print("currentPage:$currentIndex");
    if (!_loading) {
      _loading = true;
      try {
        HomeEntity result = await HomeDao.get(widget.categoryName,
            pageIndex: currentIndex, pageSize: 10);
        print(result);
        if (result.videoList != null) {
          setState(() {
            if (loadMore) {
              if (result.videoList!.isNotEmpty) {
                videoList = [...videoList, ...result.videoList!];
                pageIndex++;
              }
            } else {
              videoList = result.videoList!;
            }
          });
          Future.delayed(Duration(microseconds: 1000), () {
            _loading = false;
          });
        }
      } on NeedLogin catch (e) {
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
        showWarnToast(e.message);
        _loading = false;
      } on NeedAuth catch (e) {
        showWarnToast(e.message);
        _loading = false;
      } on HiNetError catch (e) {
        showWarnToast(e.message);
        _loading = false;
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
