import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/ranking_entity.g.dart';

import 'home_entity.dart';

@JsonSerializable()
class RankingEntity {
  int? total;
  List<HomeVideo>? list;

  RankingEntity();

  factory RankingEntity.fromJson(Map<String, dynamic> json) =>
      $RankingEntityFromJson(json);

  Map<String, dynamic> toJson() => $RankingEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
