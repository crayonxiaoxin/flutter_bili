import 'package:flutter_bili/http/request/base_request.dart';

import 'like_request.dart';

class UnLikeRequest extends LikeRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }
}
