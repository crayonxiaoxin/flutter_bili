/// 数字转万
String countFormat(int count) {
  String values = "";
  if (count > 9999) {
    values = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    values = count.toString();
  }
  return values;
}

/// 时间转换为 分钟:秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if (s < 10) {
    return "$m:0$s";
  } else {
    return "$m:$s";
  }
}
