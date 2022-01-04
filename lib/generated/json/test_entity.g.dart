import 'package:flutter_bili/generated/json/base/json_convert_content.dart';
import 'package:flutter_bili/model/test_entity.dart';

TestEntity $TestEntityFromJson(Map<String, dynamic> json) {
  final TestEntity testEntity = TestEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    testEntity.code = code;
  }
  final TestData? data = jsonConvert.convert<TestData>(json['data']);
  if (data != null) {
    testEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    testEntity.msg = msg;
  }
  return testEntity;
}

Map<String, dynamic> $TestEntityToJson(TestEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  return data;
}

TestData $TestDataFromJson(Map<String, dynamic> json) {
  final TestData testData = TestData();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    testData.code = code;
  }
  final String? method = jsonConvert.convert<String>(json['method']);
  if (method != null) {
    testData.method = method;
  }
  final String? requestPrams =
      jsonConvert.convert<String>(json['requestPrams']);
  if (requestPrams != null) {
    testData.requestPrams = requestPrams;
  }
  return testData;
}

Map<String, dynamic> $TestDataToJson(TestData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['method'] = entity.method;
  data['requestPrams'] = entity.requestPrams;
  return data;
}
