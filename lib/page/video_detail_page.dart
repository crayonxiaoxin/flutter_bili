import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("视频详情页，vid：${widget.videoModel.vid}"),
          Text("视频详情页，title：${widget.videoModel.title}"),
          _videoView(),
        ],
      ),
    );
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url ?? "",
      cover: model.cover,
    );
  }
}
