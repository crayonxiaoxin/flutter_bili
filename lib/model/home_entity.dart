import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {
  List<HomeBanner>? bannerList;
  List<HomeCategory>? categoryList;
  List<HomeVideo>? videoList;

  HomeEntity();

  factory HomeEntity.fromJson(Map<String, dynamic> json) =>
      $HomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeBanner {
  String? id;
  int? sticky;
  String? type;
  String? title;
  String? subtitle;
  String? url;
  String? cover;
  String? createTime;

  HomeBanner();

  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      $HomeBannerFromJson(json);

  Map<String, dynamic> toJson() => $HomeBannerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeCategory {
  String? name;
  int? count;

  HomeCategory();

  factory HomeCategory.fromJson(Map<String, dynamic> json) =>
      $HomeCategoryFromJson(json);

  Map<String, dynamic> toJson() => $HomeCategoryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeVideo {
  String? id;
  String? vid;
  String? title;
  String? tname;
  String? url;
  String? cover;
  int? pubdate;
  String? desc;
  int? view;
  int? duration;
  HomeVideoListOwner? owner;
  int? reply;
  int? favorite;
  int? like;
  int? coin;
  int? share;
  String? createTime;
  int? size;

  HomeVideo();

  HomeVideo.instance(
      {this.id,
      this.vid,
      this.title,
      this.tname,
      this.url,
      this.cover,
      this.pubdate,
      this.desc,
      this.view,
      this.duration,
      this.owner,
      this.reply,
      this.favorite,
      this.like,
      this.coin,
      this.share,
      this.createTime,
      this.size});

  factory HomeVideo.fromJson(Map<String, dynamic> json) =>
      $HomeVideoFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeVideoListOwner {
  String? name;
  String? face;
  int? fans;

  HomeVideoListOwner();

  factory HomeVideoListOwner.fromJson(Map<String, dynamic> json) =>
      $HomeVideoListOwnerFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoListOwnerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
