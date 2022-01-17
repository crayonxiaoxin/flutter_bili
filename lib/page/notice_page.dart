import 'package:flutter/material.dart';
import 'package:flutter_bili/core/hi_base_tab_state.dart';
import 'package:flutter_bili/http/dao/notice_dao.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/model/notice_entity.dart';
import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';
import 'package:flutter_bili/widget/notice_card.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState
    extends HiBaseTabState<NoticeEntity, HomeBanner, NoticePage> {
  @override
  PreferredSizeWidget? get appBar {
    var themeMode = ThemeProvider().getThemeMode();
    return NavigationAppBar(
      elevation: 2,
      height: 40,
      shadowColor: themeMode == ThemeMode.light ? Color(0x49eeeeee) : null,
      color: themeMode == ThemeMode.light ? Colors.white : HiColor.darkBg,
      statusStyle: themeMode == ThemeMode.light
          ? StatusStyle.DARK_CONTENT
          : StatusStyle.LIGHT_CONTENT,
      leading: BackButton(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: themeMode == ThemeMode.light ? Colors.white : HiColor.darkBg,
            alignment: Alignment.center,
            child: Text(
              "通知",
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Positioned(left: 0, child: BackButton())
        ],
      ),
    );
  }

  @override
  get contentChild => ListView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: EdgeInsets.only(top: 8),
        children: [
          ...dataList.map((e) {
            return NoticeCard(
              noticeMo: e,
            );
          }).toList()
        ],
      );

  @override
  Future<NoticeEntity> getData(int pageIndex) {
    return NoticeDao.get(pageIndex: pageIndex, pageSize: 10);
  }

  @override
  List<HomeBanner> parseList(NoticeEntity result) {
    return result.list ?? [];
  }
}
