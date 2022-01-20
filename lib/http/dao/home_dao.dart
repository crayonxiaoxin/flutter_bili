import 'package:flutter_bili/http/request/home_request.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:hi_net/hi_net.dart';

class HomeDao {
  static Future<HomeEntity> get(String categoryName,
      {int pageIndex = 1, int pageSize = 10}) async {
    var request = HomeRequest();
    request.pathParams = categoryName;
    request.addParam("pageIndex", pageIndex).addParam("pageSize", pageSize);
    // var request = SimpleRequest(
    //     path: "uapi/fa/home/$categoryName",
    //     needLogin: true,
    //     params: {"pageIndex": "$pageIndex", "pageSize": "$pageSize"});
    var result = await HiNet.getInstance().fire(request);
    print("aa  $result");
    return HomeEntity.fromJson(result['data']);
  }
}
