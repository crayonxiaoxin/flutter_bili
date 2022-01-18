import 'package:flutter_bili/http/request/notice_request.dart';
import 'package:flutter_bili/model/notice_entity.dart';
import 'package:hi_net/hi_net.dart';

class NoticeDao {
  static Future<NoticeEntity> get(
      {int pageIndex = 1, int pageSize = 10}) async {
    var request = NoticeRequest();
    request.addParam("pageIndex", pageIndex).addParam("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return NoticeEntity.fromJson(result['data']);
  }
}
