import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/request/cancel_favorite_request.dart';
import 'package:flutter_bili/http/request/favorite_request.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    var request = favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
