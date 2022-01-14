import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/notice_entity.g.dart';
import 'package:flutter_bili/model/home_entity.dart';

@JsonSerializable()
class NoticeEntity {
  int? total;
  List<HomeBanner>? list;

  NoticeEntity();

  factory NoticeEntity.fromJson(Map<String, dynamic> json) =>
      $NoticeEntityFromJson(json);

  Map<String, dynamic> toJson() => $NoticeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
