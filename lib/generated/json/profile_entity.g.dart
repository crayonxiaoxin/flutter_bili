import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/profile_entity.dart';

ProfileEntity $ProfileEntityFromJson(Map<String, dynamic> json) {
  final ProfileEntity profileEntity = ProfileEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    profileEntity.name = name;
  }
  final String? face = jsonConvert.convert<String>(json['face']);
  if (face != null) {
    profileEntity.face = face;
  }
  final int? fans = jsonConvert.convert<int>(json['fans']);
  if (fans != null) {
    profileEntity.fans = fans;
  }
  final int? favorite = jsonConvert.convert<int>(json['favorite']);
  if (favorite != null) {
    profileEntity.favorite = favorite;
  }
  final int? like = jsonConvert.convert<int>(json['like']);
  if (like != null) {
    profileEntity.like = like;
  }
  final int? coin = jsonConvert.convert<int>(json['coin']);
  if (coin != null) {
    profileEntity.coin = coin;
  }
  final int? browsing = jsonConvert.convert<int>(json['browsing']);
  if (browsing != null) {
    profileEntity.browsing = browsing;
  }
  final List<HomeBanner>? bannerList =
      jsonConvert.convertListNotNull<HomeBanner>(json['bannerList']);
  if (bannerList != null) {
    profileEntity.bannerList = bannerList;
  }
  final List<ProfileCourse>? courseList =
      jsonConvert.convertListNotNull<ProfileCourse>(json['courseList']);
  if (courseList != null) {
    profileEntity.courseList = courseList;
  }
  final List<ProfileBenefit>? benefitList =
      jsonConvert.convertListNotNull<ProfileBenefit>(json['benefitList']);
  if (benefitList != null) {
    profileEntity.benefitList = benefitList;
  }
  return profileEntity;
}

Map<String, dynamic> $ProfileEntityToJson(ProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['face'] = entity.face;
  data['fans'] = entity.fans;
  data['favorite'] = entity.favorite;
  data['like'] = entity.like;
  data['coin'] = entity.coin;
  data['browsing'] = entity.browsing;
  data['bannerList'] = entity.bannerList?.map((v) => v.toJson()).toList();
  data['courseList'] = entity.courseList?.map((v) => v.toJson()).toList();
  data['benefitList'] = entity.benefitList?.map((v) => v.toJson()).toList();
  return data;
}

ProfileCourse $ProfileCourseFromJson(Map<String, dynamic> json) {
  final ProfileCourse profileCourse = ProfileCourse();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    profileCourse.name = name;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    profileCourse.cover = cover;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    profileCourse.url = url;
  }
  final int? group = jsonConvert.convert<int>(json['group']);
  if (group != null) {
    profileCourse.group = group;
  }
  return profileCourse;
}

Map<String, dynamic> $ProfileCourseToJson(ProfileCourse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['cover'] = entity.cover;
  data['url'] = entity.url;
  data['group'] = entity.group;
  return data;
}

ProfileBenefit $ProfileBenefitFromJson(Map<String, dynamic> json) {
  final ProfileBenefit profileBenefit = ProfileBenefit();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    profileBenefit.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    profileBenefit.url = url;
  }
  return profileBenefit;
}

Map<String, dynamic> $ProfileBenefitToJson(ProfileBenefit entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['url'] = entity.url;
  return data;
}
