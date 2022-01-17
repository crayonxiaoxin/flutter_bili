import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeCard extends StatelessWidget {
  final HomeBanner? noticeMo;

  const NoticeCard({Key? key, required this.noticeMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleClick(noticeMo);
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        decoration: BoxDecoration(border: borderLine()),
        child: Row(
          children: [
            Icon(
              noticeMo?.type == 'video'
                  ? Icons.ondemand_video
                  : Icons.wallet_giftcard_sharp,
              size: 36,
            ),
            hiSpace(width: 10),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      noticeMo?.title ?? "",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(noticeMo?.createTime ?? "",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                hiSpace(height: 5),
                Text(noticeMo?.subtitle ?? "",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _handleClick(HomeBanner? banner) {
    if (banner == null) return;
    if (banner.type == 'video') {
      print("url:${banner.url}");
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoMo': HomeVideo.instance(vid: banner.url)});
    } else {
      print("type:${banner.type}, url:${banner.url}");
      _launchUrl(banner.url);
    }
  }

  void _launchUrl(String? url) async {
    if (url != null) {
      await launch(url);
    }
  }
}
