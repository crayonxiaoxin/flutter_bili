import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/profile_entity.g.dart';
import 'package:flutter_bili/model/home_entity.dart';

@JsonSerializable()
class ProfileEntity {
  String? name;
  String? face;
  int? fans;
  int? favorite;
  int? like;
  int? coin;
  int? browsing;
  List<HomeBanner>? bannerList;
  List<ProfileCourse>? courseList;
  List<ProfileBenefit>? benefitList;

  ProfileEntity();

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      $ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProfileEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileCourse {
  String? name;
  String? cover;
  String? url;
  int? group;

  ProfileCourse();

  factory ProfileCourse.fromJson(Map<String, dynamic> json) =>
      $ProfileCourseListFromJson(json);

  Map<String, dynamic> toJson() => $ProfileCourseListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileBenefit {
  String? name;
  String? url;

  ProfileBenefit();

  factory ProfileBenefit.fromJson(Map<String, dynamic> json) =>
      $ProfileBenefitListFromJson(json);

  Map<String, dynamic> toJson() => $ProfileBenefitListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
