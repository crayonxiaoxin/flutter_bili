import 'package:flutter_bili/http/request/video_detail_request.dart';
import 'package:flutter_bili/model/video_detail_entity.dart';
import 'package:hi_net/hi_net.dart';

/// 视频详情页 Dao
class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = "$vid";
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return VideoDetailEntity.fromJson(result['data']);
  }
}
