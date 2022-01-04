import 'dart:convert';

import 'package:flutter_bili/http/request/base_request.dart';

/// 网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<dynamic>> send(BaseRequest request);
}

/// 统一网络层返回格式
class HiNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
