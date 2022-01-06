import 'package:flutter/material.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:flutter_bili/util/string_util.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/app_bar.dart';
import 'package:flutter_bili/widget/login_button.dart';
import 'package:flutter_bili/widget/login_effect.dart';
import 'package:flutter_bili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJump2Login;

  const RegistrationPage({Key? key, this.onJump2Login}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String username = "";
  String password = "";
  String rePassword = "";
  String imoocId = "";
  String orderId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJump2Login),
      body: Container(
        child: ListView(
          // 自适应键盘，防遮挡
          children: [
            LoginEffect(protect: protect),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                this.username = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                this.password = text;
                checkInput();
              },
              onFocusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              obscureText: true,
              onChanged: (text) {
                this.rePassword = text;
                checkInput();
              },
              onFocusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网ID",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                this.imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              "订单号",
              "请输入订单号后四位",
              lineStretch: true,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                this.orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: LoginButton(
                  title: "注册",
                  enable: loginEnable,
                  onPressed: () {
                    if (loginEnable) {
                      checkParams();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(username) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
        }
      },
      child: Text("注册"),
    );
  }

  void send() async {
    try {
      var result =
          await LoginDao.register(username, password, orderId, imoocId);
      if (result['code'] == 0) {
        print("注册成功");
        showToast("注册成功");
        widget.onJump2Login?.call();
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      showWarnToast(tips);
      return;
    }
    send();
  }
}
