import 'package:flutter_bili/http/request/profile_request.dart';
import 'package:flutter_bili/model/profile_entity.dart';
import 'package:hi_net/hi_net.dart';

class ProfileDao {
  static Future<ProfileEntity> get() async {
    var request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileEntity.fromJson(result['data']);
  }
}
