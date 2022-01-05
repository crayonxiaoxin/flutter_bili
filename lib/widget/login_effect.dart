import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  const LoginEffect({Key? key, this.protext = false}) : super(key: key);
  final bool protext;

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(
              bottom: BorderSide(color: Colors.grey[300] ?? Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Padding(
            padding: EdgeInsets.all(20),
            child: Image(
              image: AssetImage("images/logo.png"),
            ),
          ),
          _image(false)
        ],
      ),
    );
  }

  _image(bool left) {
    var headerLeft = widget.protext
        ? "images/head_left_protect.png"
        : "images/head_left.png";
    var headerRight = widget.protext
        ? "images/head_right_protect.png"
        : "images/head_right.png";
    return Image(image: AssetImage(left ? headerLeft : headerRight));
  }
}
