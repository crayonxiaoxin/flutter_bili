import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/request/home_request.dart';
import 'package:flutter_bili/model/home_entity.dart';

class HomeDao {
  static Future<HomeEntity> get(String categoryName,
      {int pageIndex = 1, int pageSize = 10}) async {
    var request = HomeRequest();
    request.pathParams = categoryName;
    request.addParam("pageIndex", pageIndex).addParam("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print("aa  $result");
    return HomeEntity.fromJson(result['data']);
  }
}
