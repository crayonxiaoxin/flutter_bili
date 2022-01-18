import 'package:hi_net/request/hi_base_request.dart';

import 'like_request.dart';

class UnLikeRequest extends LikeRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }
}
