import 'package:flutter/material.dart';
import 'package:flutter_bili/util/color.dart';

class LoginInput extends StatefulWidget {
  const LoginInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.onFocusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType,
      this.controller})
      : super(key: key);
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChanged;
  final bool? lineStretch; // 下划线是否拉伸
  final bool? obscureText; // 密码
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 是否获取光标的监听
    _focusNode.addListener(() {
      print("has focus: ${_focusNode.hasFocus}");
      widget.onFocusChanged?.call(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(left: !(widget.lineStretch ?? false) ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType,
      cursorColor: primary,
      autofocus: !(widget.obscureText ?? false),
      controller: widget.controller,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
