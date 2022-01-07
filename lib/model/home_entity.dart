import 'dart:convert';
import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {

	List<HomeBannerList>? bannerList;
	List<HomeCategoryList>? categoryList;
	List<HomeVideoList>? videoList;
  
  HomeEntity();

  factory HomeEntity.fromJson(Map<String, dynamic> json) => $HomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeBannerList {

	String? id;
	int? sticky;
	String? type;
	String? title;
	String? subtitle;
	String? url;
	String? cover;
	String? createTime;
  
  HomeBannerList();

  factory HomeBannerList.fromJson(Map<String, dynamic> json) => $HomeBannerListFromJson(json);

  Map<String, dynamic> toJson() => $HomeBannerListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeCategoryList {

	String? name;
	int? count;
  
  HomeCategoryList();

  factory HomeCategoryList.fromJson(Map<String, dynamic> json) => $HomeCategoryListFromJson(json);

  Map<String, dynamic> toJson() => $HomeCategoryListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeVideoList {

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
  
  HomeVideoList();

  factory HomeVideoList.fromJson(Map<String, dynamic> json) => $HomeVideoListFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoListToJson(this);

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

  factory HomeVideoListOwner.fromJson(Map<String, dynamic> json) => $HomeVideoListOwnerFromJson(json);

  Map<String, dynamic> toJson() => $HomeVideoListOwnerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}