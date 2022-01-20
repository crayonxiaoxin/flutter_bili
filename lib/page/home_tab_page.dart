import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_base_tab_state.dart';
import 'package:flutter_bili/http/dao/home_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/widget/hi_banner.dart';
import 'package:flutter_bili/widget/video_card.dart';
import 'package:hi_base/adapt.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<HomeBanner>? bannerList;

  const HomeTabPage({Key? key, this.categoryName = "", this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends HiBaseTabState<HomeEntity, HomeVideo, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print(widget.categoryName);
    print(widget.bannerList);
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: HiBanner(
        widget.bannerList,
        bannerHeight: Adapt.px(150),
        padding: EdgeInsets.only(left: 5, right: 5),
      ),
    );
  }

  // @override
  // get contentChild => ListView(
  //       // 当列表内容不足撑开屏幕时，防止下拉刷新和上拉加载失效，在android上可以下拉刷新，但依然不能上拉加载
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       // 列表滚动监听
  //       controller: scrollController,
  //       padding: EdgeInsets.only(left: 8, right: 8),
  //       children: [
  //         StaggeredGrid.count(
  //           crossAxisCount: 2,
  //           mainAxisSpacing: 5,
  //           crossAxisSpacing: 5,
  //           axisDirection: AxisDirection.down,
  //           children: [
  //             if (widget.bannerList != null)
  //               StaggeredGridTile.count(
  //                   crossAxisCellCount: 2,
  //                   mainAxisCellCount: 1,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(bottom: 8),
  //                     child: _banner(),
  //                   )),
  //             ...dataList.map((e) {
  //               return StaggeredGridTile.count(
  //                   crossAxisCellCount: 1,
  //                   mainAxisCellCount: 1,
  //                   child: VideoCard(e));
  //             }).toList()
  //           ],
  //         )
  //       ],
  //     );

  @override
  get contentChild => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: EdgeInsets.only(left: 8, right: 8),
        children: [
          ...[
            if (widget.bannerList != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: _banner(),
              )
          ],
          GridView.builder(
            // [physics] 修复不能滚动的问题
            physics: NeverScrollableScrollPhysics(),
            // [shrinkWrap] 修复 `child.hasSize` is not true 问题
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.0),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return VideoCard(dataList[index]);
            },
          )
        ],
      );

  @override
  Future<HomeEntity> getData(int pageIndex) {
    return HomeDao.get(widget.categoryName, pageIndex: pageIndex, pageSize: 10);
  }

  @override
  List<HomeVideo> parseList(HomeEntity result) {
    return result.videoList ?? [];
  }
}
