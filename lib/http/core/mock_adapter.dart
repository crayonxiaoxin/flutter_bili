import 'package:flutter_bili/http/core/hi_net_adapter.dart';
import 'package:flutter_bili/http/request/base_request.dart';

/// 测试适配器，模仿数据返回
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send(BaseRequest request) {
    return Future<HiNetResponse<dynamic>>.delayed(Duration(seconds: 1), () {
      return HiNetResponse(
          data: {"code": 0, "message": "success"},
          request: request,
          statusCode: 200);
    });
  }
}
