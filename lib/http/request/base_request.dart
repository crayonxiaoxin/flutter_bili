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
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest addParam(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, String> headers = Map();

  /// 添加 header
  BaseRequest addHeader(String k, Object v) {
    headers[k] = v.toString();
    return this;
  }
}
