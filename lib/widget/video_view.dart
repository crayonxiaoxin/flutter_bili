import 'dart:io';

import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter_bili/util/adapt.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:video_player/video_player.dart';

import 'app_bar.dart';
import 'hi_video_controllers.dart';

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

  // 封面
  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );

  // 进度条颜色
  get _progressColor => ChewieProgressColors(
      playedColor: primary,
      bufferedColor: primary[50]!,
      handleColor: primary,
      backgroundColor: Colors.grey);

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
          autoPlay: widget.autoPlay,
          allowMuting: false,
          showOptions: false,
          placeholder: _placeholder,
          materialProgressColors: _progressColor,
          allowPlaybackSpeedChanging: true,
          customControls: MaterialControls(
            showBigPlayButton: false,
            showLoadingOnInitialize: false,
            bottomGradient: blackLinearGradient(),
            overlayUI: videoAppBar(ignoreStatusBar: Platform.isIOS),
          ));
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
