import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  /// 预初始化，防止 get 时还没有初始化完成
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance!;
  }

  void init() async {
    if (prefs == null) {
      // 这里是 future 类型的，可能第一次init时，prefs还未初始化成功，所以需要预初始化
      prefs = await SharedPreferences.getInstance();
    }
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
