import 'package:flutter_bili/http/request/login_request.dart';
import 'package:flutter_bili/http/request/registration_request.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:hi_net/hi_net.dart';
import 'package:hi_net/request/hi_base_request.dart';

class LoginDao {
  static const String KEY_BOARDING_PASS = "boarding-pass";

  static login(String username, String password) {
    return _send(username, password);
  }

  static register(
      String username, String password, String orderId, String imoocId) {
    return _send(username, password, orderId: orderId, imoocId: imoocId);
  }

  static _send(String username, String password, {orderId, imoocId}) async {
    HiBaseRequest request;
    if (orderId != null && imoocId != null) {
      request = RegistrationRequest();
      request
          .addParam("userName", username)
          .addParam("password", password)
          .addParam("imoocId", imoocId)
          .addParam("orderId", orderId);
    } else {
      request = LoginRequest();
      request.addParam("userName", username).addParam("password", password);
    }
    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(KEY_BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(KEY_BOARDING_PASS);
  }
}
