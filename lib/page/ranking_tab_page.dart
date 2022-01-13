import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_base_tab_state.dart';
import 'package:flutter_bili/http/dao/ranking_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/ranking_entity.dart';
import 'package:flutter_bili/widget/video_large_card.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key? key, required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingEntity, HomeVideo, RankingTabPage> {
  @override
  get contentChild => ListView(
        // 当列表内容不足撑开屏幕时，防止下拉刷新和上拉加载失效，在android上可以下拉刷新，但依然不能上拉加载
        physics: const AlwaysScrollableScrollPhysics(),
        // 列表滚动监听
        controller: scrollController,
        padding: EdgeInsets.only(top: 8),
        children: [
          ...dataList.map((e) {
            return VideoLargeCard(
              videoModel: e,
            );
          }).toList()
        ],
      );

  @override
  Future<RankingEntity> getData(int pageIndex) {
    return RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 10);
  }

  @override
  List<HomeVideo> parseList(RankingEntity result) {
    return result.list ?? [];
  }
}
