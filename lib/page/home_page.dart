import 'package:flutter/material.dart';
import 'package:flutter_bili/model/video_model.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("home page current: ${current.page}");
      print("home page pre: ${pre?.page}");
      if (current.page == widget || current.page is HomePage) {
        print("home page onResume!");
      } else if (pre?.page == widget || pre?.page is HomePage) {
        print("home page onPause!!!");
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(
              onPressed: () => HiNavigator.getInstance().onJumpTo(
                  RouteStatus.detail,
                  args: {"viewMo": VideoModel(123)}),
              child: Text("详情"),
            )
          ],
        ),
      ),
    );
  }
}
