import 'http/dao/login_dao.dart';

class Const {
  /// authToken 更新 https://coding.imooc.com/learn/questiondetail/y0K5g683G4zXe2QN.html
  static const String authTokenKey = "auth-token";
  static const String authToken = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";
  static const String courseFlagKey = "course-flag";
  static const String courseFlag = "fa";
  static const String imoocId = "10388380";
  static const String orderId = "1659";
  static const String login = "darklau";
  static const String password = "123456";

  static const String theme = "theme-mode";

  static headers() {
    Map<String, dynamic> headers = {
      Const.authTokenKey: Const.authToken,
      Const.courseFlagKey: Const.courseFlag,
    };
    // 需要登录
    headers[LoginDao.KEY_BOARDING_PASS] = LoginDao.getBoardingPass();
    return headers;
  }
}
