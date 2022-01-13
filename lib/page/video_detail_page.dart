import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/dao/favorite_dao.dart';
import 'package:flutter_bili/http/dao/like_dao.dart';
import 'package:flutter_bili/http/dao/video_detail_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/video_detail_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/expandable_content.dart';
import 'package:flutter_bili/widget/hi_tab.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:flutter_bili/widget/video_header.dart';
import 'package:flutter_bili/widget/video_large_card.dart';
import 'package:flutter_bili/widget/video_tool_bar.dart';
import 'package:flutter_bili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final HomeVideo videoModel;

  const VideoDetailPage(
    this.videoModel, {
    Key? key,
  }) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  List<String> tabs = ["简介", "评论 233"];
  TabController? _controller;
  VideoDetailEntity? _videoDetailMo;
  HomeVideo? videoModel;
  List<HomeVideo> videoList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
    _loadData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 如果是 Android，沉浸播放。如果是 iOS，则刘海屏状态栏显示为黑色背景
      extendBodyBehindAppBar: Platform.isAndroid,
      appBar: NavigationAppBar(
        height: 0,
        statusStyle: StatusStyle.LIGHT_CONTENT,
        color: Platform.isAndroid ? Colors.transparent : Colors.black,
      ),
      body: Column(
        children: [
          _buildVideoView(),
          _buildTabs(),
          Flexible(
              fit: FlexFit.loose, // child 实际大小
              child: TabBarView(
                children: [_buildDetailList(), Text("Coming soon")],
                controller: _controller,
              ))
        ],
      ),
    );
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoView(
      model?.url ?? "",
      cover: model?.cover,
      autoPlay: true,
      looping: true,
    );
  }

  _buildTabs() {
    // 实现阴影效果 Material
    return Material(
      elevation: 4,
      shadowColor: Colors.grey[100],
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabsView(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                size: 20,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabsView() {
    return HiTab(
      tabs.map((tab) {
        return Tab(
          height: 36,
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab,
              style: TextStyle(fontSize: 14),
            ),
          ),
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      unselectedLabelColor: Colors.grey[500],
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [...buildContents(), ..._buildVideoList()],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(
          owner: videoModel?.owner,
        ),
      ),
      ExpandableContent(videoMo: videoModel),
      VideoToolBar(
        detailMo: _videoDetailMo,
        videoModel: videoModel,
        onLike: _onLike,
        onUnLike: _onUnLike,
        onCoin: _onCoin,
        onFavorite: _onFavorite,
        onShare: _onShare,
      ),
    ];
  }

  void _loadData() async {
    try {
      VideoDetailEntity result =
          await VideoDetailDao.get(videoModel?.vid ?? "");
      print(result);
      setState(() {
        _videoDetailMo = result;
        videoModel = result.videoInfo;
        videoList = result.videoList ?? [];
      });
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  void _onLike() async {
    try {
      var isLike = !(_videoDetailMo?.isLike ?? false);
      var result = await LikeDao.like(videoModel?.vid ?? "", isLike);
      print(result);
      _videoDetailMo?.isLike = isLike;
      if (isLike) {
        if (videoModel?.like != null) {
          videoModel!.like = videoModel!.like! + 1;
        }
      } else {
        if (videoModel?.like != null) {
          videoModel!.like = videoModel!.like! - 1;
        }
      }
      setState(() {
        _videoDetailMo = _videoDetailMo;
        videoModel = videoModel;
      });
      showToast(result['msg']);
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  void _onUnLike() {}

  void _onCoin() {}

  void _onFavorite() async {
    try {
      var favorite = !(_videoDetailMo?.isFavorite ?? false);
      var result = await FavoriteDao.favorite(videoModel?.vid ?? "", favorite);
      print(result);
      _videoDetailMo?.isFavorite = favorite;
      if (favorite) {
        if (videoModel?.favorite != null) {
          videoModel!.favorite = videoModel!.favorite! + 1;
        }
      } else {
        if (videoModel?.favorite != null) {
          videoModel!.favorite = videoModel!.favorite! - 1;
        }
      }
      setState(() {
        _videoDetailMo = _videoDetailMo;
        videoModel = videoModel;
      });
      showToast(result['msg']);
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  void _onShare() {}

  _buildVideoList() {
    return videoList.map((e) {
      return VideoLargeCard(videoModel: e);
    }).toList();
  }
}
