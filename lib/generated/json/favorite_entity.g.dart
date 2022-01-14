import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/favorite_entity.dart';
import 'package:flutter_bili/model/home_entity.dart';

FavoriteEntity $FavoriteEntityFromJson(Map<String, dynamic> json) {
  final FavoriteEntity favoriteEntity = FavoriteEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    favoriteEntity.total = total;
  }
  final List<HomeVideo>? list =
      jsonConvert.convertListNotNull<HomeVideo>(json['list']);
  if (list != null) {
    favoriteEntity.list = list;
  }
  return favoriteEntity;
}

Map<String, dynamic> $FavoriteEntityToJson(FavoriteEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}
