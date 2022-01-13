import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/request/ranking_request.dart';
import 'package:flutter_bili/model/ranking_entity.dart';

class RankingDao {
  static Future<RankingEntity> get(String sort,
      {int pageIndex = 1, int pageSize = 10}) async {
    var request = RankingRequest();
    request
        .addParam("sort", sort)
        .addParam("pageIndex", pageIndex)
        .addParam("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingEntity.fromJson(result['data']);
  }
}
