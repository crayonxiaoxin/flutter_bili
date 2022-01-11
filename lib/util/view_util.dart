import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 带缓存的 image
Widget cachedImage(String imageUrl,
    {double? width, double? height, BoxFit fit = BoxFit.cover}) {
  return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) {
        return Container(
          color: Colors.grey[200],
        );
      },
      errorWidget: (context, url, error) => Icon(Icons.error));
}
