import 'package:dio/dio.dart';
import 'package:hi_net/request/hi_base_request.dart';

import 'hi_error.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send(HiBaseRequest request) async {
    var response;
    var options = Options(headers: request.headers);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    print("dio: $response");
    print("dio error: $error");
    if (error != null) {
      throw HiNetError(response?.statusCode, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  // 构建 HiNetResponse
  HiNetResponse buildRes(Response? response, HiBaseRequest request) {
    return HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response);
  }
}
