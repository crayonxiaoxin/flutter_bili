import 'package:flutter/material.dart';
import 'package:flutter_bili/widget/navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(
        child: Text("123"),
      ),
      body: Container(
        child: Center(
          child: Text("我的"),
        ),
      ),
    );
  }
}
