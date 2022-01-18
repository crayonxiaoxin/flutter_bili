import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:hi_net/request/hi_base_request.dart';

import '../../const.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String authority() {
    return "api.devio.org";
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
