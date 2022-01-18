/// 请求方法
enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class HiBaseRequest {
  var pathParams;
  var useHttps = true;

  String authority();

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

    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  /// 添加参数
  HiBaseRequest addParam(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 统一header
  Map<String, String> headers = {};

  /// 添加 header
  HiBaseRequest addHeader(String k, Object v) {
    headers[k] = v.toString();
    return this;
  }
}
