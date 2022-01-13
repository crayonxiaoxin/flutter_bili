import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/ranking_entity.dart';

RankingEntity $RankingEntityFromJson(Map<String, dynamic> json) {
  final RankingEntity rankingEntity = RankingEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    rankingEntity.total = total;
  }
  final List<HomeVideo>? list =
      jsonConvert.convertListNotNull<HomeVideo>(json['list']);
  if (list != null) {
    rankingEntity.list = list;
  }
  return rankingEntity;
}

Map<String, dynamic> $RankingEntityToJson(RankingEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}
