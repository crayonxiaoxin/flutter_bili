import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/widget/expandable_content.dart';
import 'package:flutter_bili/widget/hi_tab.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:flutter_bili/widget/video_header.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
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
                children: [
                  _buildDetailList(),
                  Container(
                    child: Text("coming soon"),
                  )
                ],
                controller: _controller,
              ))
        ],
      ),
    );
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url ?? "",
      cover: model.cover,
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
      children: [...buildContents()],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(
          owner: widget.videoModel.owner,
        ),
      ),
      ExpandableContent(videoMo: widget.videoModel)
    ];
  }
}
