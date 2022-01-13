import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/format_util.dart';
import 'package:flutter_bili/util/view_util.dart';

class VideoLargeCard extends StatelessWidget {
  final HomeVideo? videoModel;

  const VideoLargeCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {"videoMo": videoModel});
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(border: borderLine()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_itemImage(context), _buildContent()],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoModel?.cover,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "${durationTransform(videoModel?.duration ?? 0)}",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )),
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(left: 8, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoModel?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          _buildBottomContent()
        ],
      ),
    ));
  }

  _buildBottomContent() {
    return Column(
      children: [
        _owner(),
        hiSpace(height: 2),
        Row(
          children: [
            ...smallIconText(Icons.ondemand_video, videoModel?.view ?? 0),
            hiSpace(width: 5),
            ...smallIconText(Icons.list_alt, videoModel?.reply ?? 0)
          ],
        )
      ],
    );
  }

  _owner() {
    var owner = videoModel?.owner;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: Colors.grey)),
          child: Text("Up",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 8,
                  fontWeight: FontWeight.bold)),
        ),
        hiSpace(width: 8),
        Text(
          owner?.name ?? "",
          style: TextStyle(color: Colors.grey, fontSize: 11),
        )
      ],
    );
  }
}
