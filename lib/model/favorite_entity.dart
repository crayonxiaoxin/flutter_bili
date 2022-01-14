import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/favorite_entity.g.dart';
import 'package:flutter_bili/model/home_entity.dart';

@JsonSerializable()
class FavoriteEntity {
  int? total;
  List<HomeVideo>? list;

  FavoriteEntity();

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      $FavoriteEntityFromJson(json);

  Map<String, dynamic> toJson() => $FavoriteEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
