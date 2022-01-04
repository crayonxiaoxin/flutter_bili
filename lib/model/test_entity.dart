import 'dart:convert';

import 'package:flutter_bili/generated/json/base/json_field.dart';
import 'package:flutter_bili/generated/json/test_entity.g.dart';

@JsonSerializable()
class TestEntity {
  int? code;
  TestData? data;
  String? msg;

  TestEntity();

  factory TestEntity.fromJson(Map<String, dynamic> json) =>
      $TestEntityFromJson(json);

  Map<String, dynamic> toJson() => $TestEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TestData {
  int? code;
  String? method;
  String? requestPrams;

  TestData();

  factory TestData.fromJson(Map<String, dynamic> json) =>
      $TestDataFromJson(json);

  Map<String, dynamic> toJson() => $TestDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
