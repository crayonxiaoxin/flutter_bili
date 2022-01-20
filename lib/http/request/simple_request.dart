import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:hi_net/request/hi_base_request.dart';

import '../../const.dart';

class SimpleRequest extends HiBaseRequest {
  static const String _BASE_URL = "api.devio.org";

  late final String requestUrl;
  late final String requestUrlPath;
  late final HttpMethod requestMethod;
  late final bool shouldLogin;

  SimpleRequest({
    url = _BASE_URL,
    required String path,
    HttpMethod method = HttpMethod.GET,
    Map<String, String> params = const {},
    bool needLogin = false,
  }) {
    requestUrl = url;
    requestUrlPath = path;
    requestMethod = method;
    shouldLogin = needLogin;
    this.params = params;
  }

  @override
  String authority() {
    return requestUrl;
  }

  @override
  HttpMethod httpMethod() {
    return requestMethod;
  }

  @override
  bool needLogin() {
    return shouldLogin;
  }

  @override
  String path() {
    return requestUrlPath;
  }

  @override
  Map<String, String> headers = {
    Const.courseFlagKey: Const.courseFlag,
    Const.authTokenKey: Const.authToken
  };

  @override
  String url() {
    // 需要登录的接口，携带登录令牌
    if (needLogin()) {
      addHeader(LoginDao.KEY_BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return super.url();
  }
}
