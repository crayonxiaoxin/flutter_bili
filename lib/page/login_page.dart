import 'package:flutter/material.dart';
import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:flutter_bili/navigator/hi_navigator.dart';
import 'package:flutter_bili/util/toast.dart';
import 'package:flutter_bili/widget/app_bar.dart';
import 'package:flutter_bili/widget/login_button.dart';
import 'package:flutter_bili/widget/login_effect.dart';
import 'package:flutter_bili/widget/login_input.dart';
import 'package:hi_base/string_util.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:hi_net/core/hi_error.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String KEY_LOGIN_NAME = "login-name";
  bool protect = false;
  bool loginEnable = false;
  String username = "";
  String password = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    var lastLoginName = HiCache.getInstance().get(KEY_LOGIN_NAME);
    if (lastLoginName != null) {
      // showToast(lastLoginName);
      controller.text = lastLoginName;
      username = lastLoginName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("登录", "注册", () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }, backPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.maybePop(context);
        } else {
          HiNavigator.getInstance().exit(); // 退出应用
        }
      }),
      body: Container(
        child: ListView(
          // 自适应键盘，防遮挡
          children: [
            LoginEffect(protect: protect),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            LoginInput(
              "用户名",
              "请输入用户名",
              controller: controller,
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
            Padding(
              padding: EdgeInsets.all(20),
              child: LoginButton(
                title: "登录",
                enable: loginEnable,
                onPressed: send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
      HiCache.getInstance().setString(KEY_LOGIN_NAME, username);
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(username, password);
      if (result['code'] == 0) {
        print("登录成功");
        showToast("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
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
}
