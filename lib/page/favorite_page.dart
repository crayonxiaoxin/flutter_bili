import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_base_tab_state.dart';
import 'package:flutter_bili/http/dao/favorite_dao.dart';
import 'package:flutter_bili/model/favorite_entity.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/page/video_detail_page.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:flutter_bili/widget/video_large_card.dart';
import 'package:hi_base/color.dart';
import 'package:provider/src/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState
    extends HiBaseTabState<FavoriteEntity, HomeVideo, FavoritePage> {
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener((current, pre) {
      // 从详情页返回时，自动刷新数据
      if (pre?.page is VideoDetailPage && current.page is FavoritePage) {
        loadData();
      }
    });
  }

  @override
  PreferredSizeWidget? get appBar {
    var themeProvider = context.watch<ThemeProvider>();
    return NavigationAppBar(
      elevation: 2,
      height: 40,
      shadowColor: themeProvider.isDarkMode() ? null : Color(0x49eeeeee),
      color: themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
      statusStyle: themeProvider.isDarkMode()
          ? StatusStyle.LIGHT_CONTENT
          : StatusStyle.DARK_CONTENT,
      child: Container(
        color: themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
        alignment: Alignment.center,
        child: Text(
          "收藏",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // @override
  // get contentChild => ListView(
  //       physics: AlwaysScrollableScrollPhysics(),
  //       controller: scrollController,
  //       padding: EdgeInsets.only(top: 8),
  //       children: [
  //         ...dataList.map((e) {
  //           return VideoLargeCard(videoModel: e);
  //         }).toList()
  //       ],
  //     );

  @override
  get contentChild => ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: EdgeInsets.only(top: 8),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return VideoLargeCard(videoModel: dataList[index]);
        },
      );

  @override
  Future<FavoriteEntity> getData(int pageIndex) {
    return FavoriteDao.get(pageIndex: pageIndex, pageSize: 10);
  }

  @override
  List<HomeVideo> parseList(FavoriteEntity result) {
    return result.list ?? [];
  }
}
