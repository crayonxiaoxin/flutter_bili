import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/util/format_util.dart';

/// 带缓存的 image
Widget cachedImage(String? imageUrl,
    {double? width, double? height, BoxFit fit = BoxFit.cover}) {
  return imageUrl != null
      ? CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) {
            return Container(
              color: Colors.grey[200],
            );
          },
          errorWidget: (context, url, error) => Icon(Icons.error))
      : Container();
}

/// 黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ],
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter);
}

/// 文字 icon 组合
smallIconText(IconData icon, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      icon,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      " $text",
      style: style,
    )
  ];
}

/// border
borderLine({bottom: true, top: false}) {
  var borderSide = BorderSide(color: Colors.grey[200]!, width: 0.5);
  return Border(
    top: top ? borderSide : BorderSide.none,
    bottom: bottom ? borderSide : BorderSide.none,
  );
}

/// 间距
SizedBox hiSpace({double height = 1, double width = 1}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

// 底部阴影
BoxDecoration bottomBoxShadow({color = Colors.white, shadowColor}) {
  return BoxDecoration(color: color, boxShadow: [
    BoxShadow(
        color: shadowColor ?? Colors.grey[100]!,
        offset: Offset(0.0, 5.0),
        // 阴影模糊程度
        blurRadius: 5.0,
        // 阴影扩散程度
        spreadRadius: 1.0)
  ]);
}
