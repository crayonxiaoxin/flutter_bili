import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeBanner>? bannerList =
      jsonConvert.convertListNotNull<HomeBanner>(json['bannerList']);
  if (bannerList != null) {
    homeEntity.bannerList = bannerList;
  }
  final List<HomeCategory>? categoryList =
      jsonConvert.convertListNotNull<HomeCategory>(json['categoryList']);
  if (categoryList != null) {
    homeEntity.categoryList = categoryList;
  }
  final List<HomeVideo>? videoList =
      jsonConvert.convertListNotNull<HomeVideo>(json['videoList']);
  if (videoList != null) {
    homeEntity.videoList = videoList;
  }
  return homeEntity;
}

Map<String, dynamic> $HomeEntityToJson(HomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bannerList'] = entity.bannerList?.map((v) => v.toJson()).toList();
  data['categoryList'] = entity.categoryList?.map((v) => v.toJson()).toList();
  data['videoList'] = entity.videoList?.map((v) => v.toJson()).toList();
  return data;
}

HomeBanner $HomeBannerFromJson(Map<String, dynamic> json) {
  final HomeBanner homeBanner = HomeBanner();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    homeBanner.id = id;
  }
  final int? sticky = jsonConvert.convert<int>(json['sticky']);
  if (sticky != null) {
    homeBanner.sticky = sticky;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    homeBanner.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeBanner.title = title;
  }
  final String? subtitle = jsonConvert.convert<String>(json['subtitle']);
  if (subtitle != null) {
    homeBanner.subtitle = subtitle;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeBanner.url = url;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    homeBanner.cover = cover;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    homeBanner.createTime = createTime;
  }
  return homeBanner;
}

Map<String, dynamic> $HomeBannerToJson(HomeBanner entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['sticky'] = entity.sticky;
  data['type'] = entity.type;
  data['title'] = entity.title;
  data['subtitle'] = entity.subtitle;
  data['url'] = entity.url;
  data['cover'] = entity.cover;
  data['createTime'] = entity.createTime;
  return data;
}

HomeCategory $HomeCategoryFromJson(Map<String, dynamic> json) {
  final HomeCategory homeCategory = HomeCategory();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    homeCategory.name = name;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    homeCategory.count = count;
  }
  return homeCategory;
}

Map<String, dynamic> $HomeCategoryToJson(HomeCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['count'] = entity.count;
  return data;
}

HomeVideo $HomeVideoFromJson(Map<String, dynamic> json) {
  final HomeVideo homeVideo = HomeVideo();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    homeVideo.id = id;
  }
  final String? vid = jsonConvert.convert<String>(json['vid']);
  if (vid != null) {
    homeVideo.vid = vid;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeVideo.title = title;
  }
  final String? tname = jsonConvert.convert<String>(json['tname']);
  if (tname != null) {
    homeVideo.tname = tname;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeVideo.url = url;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    homeVideo.cover = cover;
  }
  final int? pubdate = jsonConvert.convert<int>(json['pubdate']);
  if (pubdate != null) {
    homeVideo.pubdate = pubdate;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    homeVideo.desc = desc;
  }
  final int? view = jsonConvert.convert<int>(json['view']);
  if (view != null) {
    homeVideo.view = view;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    homeVideo.duration = duration;
  }
  final HomeVideoListOwner? owner =
      jsonConvert.convert<HomeVideoListOwner>(json['owner']);
  if (owner != null) {
    homeVideo.owner = owner;
  }
  final int? reply = jsonConvert.convert<int>(json['reply']);
  if (reply != null) {
    homeVideo.reply = reply;
  }
  final int? favorite = jsonConvert.convert<int>(json['favorite']);
  if (favorite != null) {
    homeVideo.favorite = favorite;
  }
  final int? like = jsonConvert.convert<int>(json['like']);
  if (like != null) {
    homeVideo.like = like;
  }
  final int? coin = jsonConvert.convert<int>(json['coin']);
  if (coin != null) {
    homeVideo.coin = coin;
  }
  final int? share = jsonConvert.convert<int>(json['share']);
  if (share != null) {
    homeVideo.share = share;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    homeVideo.createTime = createTime;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    homeVideo.size = size;
  }
  return homeVideo;
}

Map<String, dynamic> $HomeVideoToJson(HomeVideo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['vid'] = entity.vid;
  data['title'] = entity.title;
  data['tname'] = entity.tname;
  data['url'] = entity.url;
  data['cover'] = entity.cover;
  data['pubdate'] = entity.pubdate;
  data['desc'] = entity.desc;
  data['view'] = entity.view;
  data['duration'] = entity.duration;
  data['owner'] = entity.owner?.toJson();
  data['reply'] = entity.reply;
  data['favorite'] = entity.favorite;
  data['like'] = entity.like;
  data['coin'] = entity.coin;
  data['share'] = entity.share;
  data['createTime'] = entity.createTime;
  data['size'] = entity.size;
  return data;
}

HomeVideoListOwner $HomeVideoListOwnerFromJson(Map<String, dynamic> json) {
  final HomeVideoListOwner homeVideoListOwner = HomeVideoListOwner();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    homeVideoListOwner.name = name;
  }
  final String? face = jsonConvert.convert<String>(json['face']);
  if (face != null) {
    homeVideoListOwner.face = face;
  }
  final int? fans = jsonConvert.convert<int>(json['fans']);
  if (fans != null) {
    homeVideoListOwner.fans = fans;
  }
  return homeVideoListOwner;
}

Map<String, dynamic> $HomeVideoListOwnerToJson(HomeVideoListOwner entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['face'] = entity.face;
  data['fans'] = entity.fans;
  return data;
}
