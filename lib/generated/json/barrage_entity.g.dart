import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/barrage_entity.dart';

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
