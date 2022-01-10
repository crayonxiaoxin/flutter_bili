import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<HomeBanner>? bannerList;
  final double? bannerHeight;
  final EdgeInsetsGeometry? padding;

  const HiBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bannerList != null
        ? Container(
            height: bannerHeight,
            child: _banner(),
          )
        : Container();
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList!.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: _image(bannerList![index]),
        );
      },
      //指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60,
              activeColor: Colors.white,
              size: 6,
              activeSize: 8)),
    );
  }

  _image(HomeBanner banner) {
    return InkWell(
      onTap: () {
        _handleClick(banner);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            banner.cover ?? "",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void _handleClick(HomeBanner banner) {
    if (banner.type == 'video') {
      print("url:${banner.url}");
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoMo': HomeVideo.instance(vid: banner.url)});
    } else {
      print("type:${banner.type}, url:${banner.url}");
      // todo
    }
  }
}
