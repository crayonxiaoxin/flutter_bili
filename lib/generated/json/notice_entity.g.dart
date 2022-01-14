import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/notice_entity.dart';

NoticeEntity $NoticeEntityFromJson(Map<String, dynamic> json) {
  final NoticeEntity noticeEntity = NoticeEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    noticeEntity.total = total;
  }
  final List<HomeBanner>? list =
      jsonConvert.convertListNotNull<HomeBanner>(json['list']);
  if (list != null) {
    noticeEntity.list = list;
  }
  return noticeEntity;
}

Map<String, dynamic> $NoticeEntityToJson(NoticeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}
