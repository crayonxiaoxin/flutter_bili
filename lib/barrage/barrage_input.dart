import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/view_util.dart';

class BarrageInput extends StatelessWidget {
  final VoidCallback? onTabClose;

  const BarrageInput({Key? key, this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    onTabClose?.call();
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ))),
          SafeArea(
              child: Container(
            color: Colors.white,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(editingController, context),
                _buildSendButton(editingController, context),
              ],
            ),
          ))
        ],
      ),
    );
  }

  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            hintText: "发个友善的弹幕见证当下"),
      ),
    ));
  }

  _buildSendButton(
      TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text.trim();
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _send(String value, BuildContext context) {
    if (value.isNotEmpty) {
      onTabClose?.call();
      Navigator.pop(context, value);
    }
  }
}
