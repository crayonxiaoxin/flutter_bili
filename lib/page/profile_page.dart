import 'package:flutter/material.dart';
import 'package:flutter_bili/http/dao/profile_dao.dart';
import 'package:flutter_bili/model/profile_entity.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/benefit_card.dart';
import 'package:flutter_bili/widget/course_card.dart';
import 'package:flutter_bili/widget/dark_mode_item.dart';
import 'package:flutter_bili/widget/hi_banner.dart';
import 'package:flutter_bili/widget/hi_blur.dart';
import 'package:flutter_bili/widget/hi_flexible_header.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/hi_state.dart';
import 'package:hi_base/view_util.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:provider/src/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends HiState<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  static double expandedHeight = 180; // 可收缩区域的高度

  ProfileEntity? _profileMo;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavigationAppBar(
        statusStyle: themeProvider.isDarkMode()
            ? StatusStyle.LIGHT_CONTENT
            : StatusStyle.DARK_CONTENT,
        height: 0,
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_buildSliverAppBar(themeProvider)];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [..._buildContentList()],
        ),
      ),
    );
  }

  _buildSliverAppBar(ThemeProvider themeProvider) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      elevation: 2,
      backgroundColor:
          themeProvider.isDarkMode() ? HiColor.darkBg : Colors.white,
      shadowColor: Color(0x49eeeeee),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 0, bottom: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(child: cachedImage(_profileMo?.face)),
            Positioned.fill(
                child: HiBlur(
              sigma: 20,
            )),
            Positioned(
              child: _buildProfileTab(),
              left: 0,
              right: 0,
              bottom: 0,
            )
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileEntity result = await ProfileDao.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedLogin catch (e) {
      HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
      name: _profileMo?.name,
      face: _profileMo?.face,
      controller: _scrollController,
      expandedHeight: expandedHeight,
      initialOffset: 40,
    );
  }

  _buildContentList() {
    if (_profileMo == null) return [];
    return [
      _buildBanner(),
      CourseCard(
        courseList: _profileMo?.courseList,
      ),
      BenefitCard(
        benefitList: _profileMo?.benefitList,
      ),
      DarkModeItem(),
    ];
  }

  _buildBanner() {
    return HiBanner(
      _profileMo?.bannerList,
      bannerHeight: 140,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTab() {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileMo?.favorite),
          _buildIconText("点赞", _profileMo?.like),
          _buildIconText("浏览", _profileMo?.browsing),
          _buildIconText("金币", _profileMo?.coin),
          _buildIconText("粉丝", _profileMo?.fans)
        ],
      ),
    );
  }

  _buildIconText(String? title, int? count) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text("$title",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]!)),
      ],
    );
  }
}
