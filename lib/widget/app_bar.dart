import 'package:flutter/material.dart';
import 'package:flutter_bili/util/adapt.dart';
import 'package:flutter_bili/util/view_util.dart';

/// 自定义顶部 appBar（登录、注册）
appBar(String title, String rightTitle, VoidCallback? rightButtonClick,
    {VoidCallback? backPressed}) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(
      onPressed: backPressed,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

videoAppBar({bool ignoreStatusBar = false, VoidCallback? onBack}) {
  return Container(
    padding: EdgeInsets.only(
        right: 8, top: ignoreStatusBar ? 0 : Adapt.paddingTop()),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
          onPressed: onBack,
        ),
        Row(
          children: [
            Icon(
              Icons.live_tv_rounded,
              size: 20,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.more_vert_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
