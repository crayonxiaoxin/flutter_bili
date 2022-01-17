import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/model/profile_entity.dart';
import 'package:flutter_bili/util/adapt.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:flutter_bili/widget/hi_blur.dart';
import 'package:url_launcher/url_launcher.dart';

class BenefitCard extends StatelessWidget {
  final List<ProfileBenefit>? benefitList;

  const BenefitCard({Key? key, this.benefitList = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildTitle(),
          _buildContent(),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 8, left: 10, right: 10),
      child: Row(
        children: [
          Text(
            "增值服务",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "请登录慕课网查看",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildContent() {
    var screenWidth = Adapt.screenWidth();
    if (benefitList == null) return [];
    var list = benefitList!;
    var width = (screenWidth - 20 - (list.length - 1) * 5) / list.length;
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo, width)).toList()],
      ),
    );
  }

  _buildCard(ProfileBenefit mo, double width) {
    return InkWell(
      onTap: () {
        _handleClick(mo);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(color: Colors.pinkAccent),
              child: Stack(
                children: [
                  Positioned.fill(child: HiBlur()),
                  Positioned.fill(
                      child: Center(
                    child: Text(
                      "${mo.name}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ))
                ],
              )),
        ),
      ),
    );
  }

  void _handleClick(ProfileBenefit mo) {
    if (mo.url?.contains("http") == true) {
      _launchUrl(mo.url);
    } else {
      FlutterClipboard.copy("${mo.url}").then((value) {
        showToast("${mo.url} 已复制到剪贴板");
      });
    }
  }

  void _launchUrl(String? url) async {
    if (url != null) {
      await launch(url);
    }
  }
}
