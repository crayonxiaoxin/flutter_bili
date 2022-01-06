import 'package:flutter/material.dart';
import 'package:flutter_bili/model/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJump2Detail;

  const HomePage({Key? key, this.onJump2Detail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(
              onPressed: () => widget.onJump2Detail?.call(VideoModel(123)),
              child: Text("详情"),
            )
          ],
        ),
      ),
    );
  }
}
