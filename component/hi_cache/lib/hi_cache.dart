library hi_cache;

import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(this.prefs);

  /// 预初始化，防止 get 时还没有初始化完成
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    _instance ??= HiCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  HiCache setBool(String key, bool value) {
    prefs?.setBool(key, value);
    return this;
  }

  HiCache setInt(String key, int value) {
    prefs?.setInt(key, value);
    return this;
  }

  HiCache setDouble(String key, double value) {
    prefs?.setDouble(key, value);
    return this;
  }

  HiCache setString(String key, String value) {
    prefs?.setString(key, value);
    return this;
  }

  HiCache setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
    return this;
  }

  T? get<T>(String key) {
    return prefs?.get(key) as T?;
  }
}
