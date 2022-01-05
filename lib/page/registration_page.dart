import 'package:flutter/material.dart';
import 'package:flutter_bili/widget/app_bar.dart';
import 'package:flutter_bili/widget/login_effect.dart';
import 'package:flutter_bili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("right click");
      }),
      body: Container(
        child: ListView(
          // 自适应键盘，防遮挡
          children: [
            LoginEffect(protext: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                print(text);
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                print(text);
              },
              onFocusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
