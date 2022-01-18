import 'package:hi_net/request/hi_base_request.dart';

import 'hi_net_adapter.dart';

/// 测试适配器，模仿数据返回
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send(HiBaseRequest request) {
    return Future<HiNetResponse<dynamic>>.delayed(const Duration(seconds: 1),
        () {
      return HiNetResponse(
          data: {"code": 0, "message": "success"},
          request: request,
          statusCode: 200);
    });
  }
}
