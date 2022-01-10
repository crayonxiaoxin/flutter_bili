import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/widget/hi_banner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<HomeBanner>? bannerList;

  const HomeTabPage({Key? key, this.name = "", this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      // child: ListView(
      //   children: [if (widget.bannerList != null) _banner()],
      // ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        children: [
          if (widget.bannerList != null)
            StaggeredGridTile.count(
                crossAxisCellCount: 2, mainAxisCellCount: 1, child: _banner()),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Text(
                "123",
              )),
          StaggeredGridTile.count(
              crossAxisCellCount: 1, mainAxisCellCount: 1, child: Text("236")),
          StaggeredGridTile.count(
              crossAxisCellCount: 1, mainAxisCellCount: 2, child: Text("237"))
        ],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        widget.bannerList,
        bannerHeight: 150,
      ),
    );
  }
}
