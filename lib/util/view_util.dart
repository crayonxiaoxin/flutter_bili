import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
