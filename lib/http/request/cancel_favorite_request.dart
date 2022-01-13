import 'package:flutter_bili/http/request/base_request.dart';
import 'package:flutter_bili/http/request/favorite_request.dart';

class CancelFavoriteRequest extends FavoriteRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }
}
