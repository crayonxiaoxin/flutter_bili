import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/format_util.dart';
import 'package:flutter_bili/util/view_util.dart';

class VideoHeader extends StatelessWidget {
  final HomeVideoListOwner? owner;

  const VideoHeader({Key? key, this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: cachedImage(owner?.face, width: 30, height: 30),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owner?.name ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${countFormat(owner?.fans ?? 0)}粉丝",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          MaterialButton(
            onPressed: () {
              print("-------关注-------");
            },
            height: 24,
            minWidth: 50,
            color: primary,
            child: Text(
              "+ 关注",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}