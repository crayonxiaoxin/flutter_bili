import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/util/adapt.dart';
import 'package:video_player/video_player.dart';

/// 播放器组件
class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const VideoView(this.url,
      {Key? key,
      this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // 初始化播放器设置
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _initPlayer(); // 初始化 VideoPlayerController
    if (_videoPlayerController != null) {
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoInitialize: true,
          looping: widget.looping,
          aspectRatio: widget.aspectRatio,
          autoPlay: widget.autoPlay);
    }
  }

  void _initPlayer() async {
    await _videoPlayerController?.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Adapt.screenWidth();
    double playerHeight = screenWidth / widget.aspectRatio;
    return _chewieController != null
        ? Container(
            width: screenWidth,
            height: playerHeight,
            color: Colors.grey,
            child: Chewie(controller: _chewieController!),
          )
        : Container();
  }
}
