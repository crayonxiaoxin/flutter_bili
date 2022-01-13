import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/video_detail_entity.dart';

VideoDetailEntity $VideoDetailEntityFromJson(Map<String, dynamic> json) {
  final VideoDetailEntity videoDetailEntity = VideoDetailEntity();
  final bool? isFavorite = jsonConvert.convert<bool>(json['isFavorite']);
  if (isFavorite != null) {
    videoDetailEntity.isFavorite = isFavorite;
  }
  final bool? isLike = jsonConvert.convert<bool>(json['isLike']);
  if (isLike != null) {
    videoDetailEntity.isLike = isLike;
  }
  final HomeVideo? videoInfo =
      jsonConvert.convert<HomeVideo>(json['videoInfo']);
  if (videoInfo != null) {
    videoDetailEntity.videoInfo = videoInfo;
  }
  final List<HomeVideo>? videoList =
      jsonConvert.convertListNotNull<HomeVideo>(json['videoList']);
  if (videoList != null) {
    videoDetailEntity.videoList = videoList;
  }
  return videoDetailEntity;
}

Map<String, dynamic> $VideoDetailEntityToJson(VideoDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isFavorite'] = entity.isFavorite;
  data['isLike'] = entity.isLike;
  data['videoInfo'] = entity.videoInfo?.toJson();
  data['videoList'] = entity.videoList?.map((v) => v.toJson()).toList();
  return data;
}
