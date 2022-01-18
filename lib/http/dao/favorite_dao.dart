import 'package:flutter_bili/http/request/cancel_favorite_request.dart';
import 'package:flutter_bili/http/request/favorite_request.dart';
import 'package:flutter_bili/http/request/favorites_request.dart';
import 'package:flutter_bili/model/favorite_entity.dart';
import 'package:hi_net/hi_net.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    var request = favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }

  static Future<FavoriteEntity> get(
      {int pageIndex = 1, int pageSize = 10}) async {
    var request = FavoritesRequest();
    request.addParam("pageIndex", pageIndex).addParam("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return FavoriteEntity.fromJson(result['data']);
  }
}
