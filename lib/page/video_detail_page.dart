import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
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

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
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
          _videoView(),
          Text("视频详情页，vid：${widget.videoModel.vid}"),
          Text("视频详情页，title：${widget.videoModel.title}"),
        ],
      ),
    );
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url ?? "",
      cover: model.cover,
      autoPlay: true,
      looping: true,
    );
  }
}
