import 'package:flutter_bili/http/dao/login_dao.dart';

import '../../const.dart';

/// 请求方法
enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print("url:${uri.toString()}");
    // 需要登录的接口，携带登录令牌
    if (needLogin()) {
      addHeader(LoginDao.KEY_BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest addParam(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 统一header
  Map<String, String> headers = {
    "course-flag": Const.courseFlag,
    "auth-token": Const.authToken
  };

  /// 添加 header
  BaseRequest addHeader(String k, Object v) {
    headers[k] = v.toString();
    return this;
  }
}
