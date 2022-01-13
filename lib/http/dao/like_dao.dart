import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/request/like_request.dart';
import 'package:flutter_bili/http/request/unlike_request.dart';

class LikeDao {
  static like(String vid, bool like) async {
    var request = like ? LikeRequest() : UnLikeRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
