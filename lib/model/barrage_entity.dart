import 'dart:convert';

import 'package:flutter_bili/generated/json/barrage_entity.g.dart';
import 'package:flutter_bili/generated/json/base/json_field.dart';

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
