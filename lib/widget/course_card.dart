import 'package:flutter/material.dart';
import 'package:flutter_bili/model/profile_entity.dart';
import 'package:flutter_bili/util/adapt.dart';
import 'package:flutter_bili/util/view_util.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCard extends StatelessWidget {
  final List<ProfileCourse>? courseList;

  const CourseCard({Key? key, this.courseList = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildTitle(),
          ..._buildContent(),
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
            "职场进阶",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            "带你突破技术瓶颈",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildContent() {
    var screenWidth = Adapt.screenWidth();
    if (courseList == null) return [];
    Map<int, List<ProfileCourse>> map = Map();
    courseList!.forEach((course) {
      var group = course.group ?? 0;
      if (!map.containsKey(course.group)) {
        map[group] = [];
      }
      List<ProfileCourse>? list = map[group];
      list?.add(course);
    });
    return map.entries.map((e) {
      var list = e.value;
      var width = (screenWidth - 20 - (list.length - 1) * 5) / list.length;
      var height = width / 16 * 6;
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...list.map((mo) => _buildCard(mo, width, height)).toList()
          ],
        ),
      );
    });
  }

  _buildCard(ProfileCourse mo, double width, double height) {
    return InkWell(
      onTap: () {
        _handleClick(mo);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: cachedImage(mo.cover, width: width, height: height),
        ),
      ),
    );
  }

  void _handleClick(ProfileCourse mo) {
    _launchUrl(mo.url);
  }

  void _launchUrl(String? url) async {
    if (url != null) {
      await launch(url);
    }
  }
}
