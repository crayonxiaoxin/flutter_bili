import 'dart:convert';

import 'json/json_convert_content.dart';
import 'json/json_field.dart';

@JsonSerializable()
class BarrageEntity {
  String? content;
  String? vid;
  int? priority;
  int? type;

  BarrageEntity();

  BarrageEntity.instance(
      {required this.content,
      this.vid = "-1",
      this.priority = 1,
      this.type = 1});

  factory BarrageEntity.fromJson(Map<String, dynamic> json) =>
      $BarrageEntityFromJson(json);

  Map<String, dynamic> toJson() => $BarrageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  static List<BarrageEntity> fromJsonString(json) {
    List<BarrageEntity> list = [];
    if (json == null || !(json is String) || !json.startsWith('[')) {
      print('json is not invalid');
      return [];
    }

    var jsonArray = jsonDecode(json);
    jsonArray.forEach((v) {
      list.add(new BarrageEntity.fromJson(v));
    });
    return list;
  }
}

BarrageEntity $BarrageEntityFromJson(Map<String, dynamic> json) {
  final BarrageEntity barrageEntity = BarrageEntity();
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    barrageEntity.content = content;
  }
  final String? vid = jsonConvert.convert<String>(json['vid']);
  if (vid != null) {
    barrageEntity.vid = vid;
  }
  final int? priority = jsonConvert.convert<int>(json['priority']);
  if (priority != null) {
    barrageEntity.priority = priority;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    barrageEntity.type = type;
  }
  return barrageEntity;
}

Map<String, dynamic> $BarrageEntityToJson(BarrageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['content'] = entity.content;
  data['vid'] = entity.vid;
  data['priority'] = entity.priority;
  data['type'] = entity.type;
  return data;
}
