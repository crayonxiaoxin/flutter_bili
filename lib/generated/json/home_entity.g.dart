import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeBannerList>? bannerList =
      jsonConvert.convertListNotNull<HomeBannerList>(json['bannerList']);
  if (bannerList != null) {
    homeEntity.bannerList = bannerList;
  }
  final List<HomeCategoryList>? categoryList =
      jsonConvert.convertListNotNull<HomeCategoryList>(json['categoryList']);
  if (categoryList != null) {
    homeEntity.categoryList = categoryList;
  }
  final List<HomeVideoList>? videoList =
      jsonConvert.convertListNotNull<HomeVideoList>(json['videoList']);
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

HomeBannerList $HomeBannerListFromJson(Map<String, dynamic> json) {
  final HomeBannerList homeBannerList = HomeBannerList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    homeBannerList.id = id;
  }
  final int? sticky = jsonConvert.convert<int>(json['sticky']);
  if (sticky != null) {
    homeBannerList.sticky = sticky;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    homeBannerList.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeBannerList.title = title;
  }
  final String? subtitle = jsonConvert.convert<String>(json['subtitle']);
  if (subtitle != null) {
    homeBannerList.subtitle = subtitle;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeBannerList.url = url;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    homeBannerList.cover = cover;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    homeBannerList.createTime = createTime;
  }
  return homeBannerList;
}

Map<String, dynamic> $HomeBannerListToJson(HomeBannerList entity) {
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

HomeCategoryList $HomeCategoryListFromJson(Map<String, dynamic> json) {
  final HomeCategoryList homeCategoryList = HomeCategoryList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    homeCategoryList.name = name;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    homeCategoryList.count = count;
  }
  return homeCategoryList;
}

Map<String, dynamic> $HomeCategoryListToJson(HomeCategoryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['count'] = entity.count;
  return data;
}

HomeVideoList $HomeVideoListFromJson(Map<String, dynamic> json) {
  final HomeVideoList homeVideoList = HomeVideoList();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    homeVideoList.id = id;
  }
  final String? vid = jsonConvert.convert<String>(json['vid']);
  if (vid != null) {
    homeVideoList.vid = vid;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeVideoList.title = title;
  }
  final String? tname = jsonConvert.convert<String>(json['tname']);
  if (tname != null) {
    homeVideoList.tname = tname;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    homeVideoList.url = url;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    homeVideoList.cover = cover;
  }
  final int? pubdate = jsonConvert.convert<int>(json['pubdate']);
  if (pubdate != null) {
    homeVideoList.pubdate = pubdate;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    homeVideoList.desc = desc;
  }
  final int? view = jsonConvert.convert<int>(json['view']);
  if (view != null) {
    homeVideoList.view = view;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    homeVideoList.duration = duration;
  }
  final HomeVideoListOwner? owner =
      jsonConvert.convert<HomeVideoListOwner>(json['owner']);
  if (owner != null) {
    homeVideoList.owner = owner;
  }
  final int? reply = jsonConvert.convert<int>(json['reply']);
  if (reply != null) {
    homeVideoList.reply = reply;
  }
  final int? favorite = jsonConvert.convert<int>(json['favorite']);
  if (favorite != null) {
    homeVideoList.favorite = favorite;
  }
  final int? like = jsonConvert.convert<int>(json['like']);
  if (like != null) {
    homeVideoList.like = like;
  }
  final int? coin = jsonConvert.convert<int>(json['coin']);
  if (coin != null) {
    homeVideoList.coin = coin;
  }
  final int? share = jsonConvert.convert<int>(json['share']);
  if (share != null) {
    homeVideoList.share = share;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    homeVideoList.createTime = createTime;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    homeVideoList.size = size;
  }
  return homeVideoList;
}

Map<String, dynamic> $HomeVideoListToJson(HomeVideoList entity) {
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
