import 'package:flutter_test/flutter_test.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  /// 单元测试
  test("测试 HiCache", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await HiCache.preInit();
    var key = "testCache";
    var value = "Hello world.";
    HiCache.getInstance().setString(key, value);
    // 比对
    expect(HiCache.getInstance().get(key), value);
  });
}
