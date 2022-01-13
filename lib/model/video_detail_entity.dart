import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/video_detail_entity.g.dart';
import 'package:flutter_bili/model/home_entity.dart';

@JsonSerializable()
class VideoDetailEntity {
  bool? isFavorite;
  bool? isLike;
  HomeVideo? videoInfo;
  List<HomeVideo>? videoList;

  VideoDetailEntity();

  factory VideoDetailEntity.fromJson(Map<String, dynamic> json) =>
      $VideoDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $VideoDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
