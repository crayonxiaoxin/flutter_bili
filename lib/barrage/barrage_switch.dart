import 'package:flutter/material.dart';
import 'package:flutter_bili/util/color.dart';
import 'package:flutter_bili/util/view_util.dart';

class BarrageSwitch extends StatefulWidget {
  // 初始化时是否展开
  final bool initSwitch;

  // 是否为输入中
  final bool inputShowing;

  final VoidCallback? onShowingInput;
  final ValueChanged? onBarrageSwitch;

  const BarrageSwitch(
      {Key? key,
      this.initSwitch = true,
      this.inputShowing = false,
      this.onShowingInput,
      this.onBarrageSwitch})
      : super(key: key);

  @override
  _BarrageSwitchState createState() => _BarrageSwitchState();
}

class _BarrageSwitchState extends State<BarrageSwitch> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            if (isExpanded)
              InkWell(
                onTap: () {
                  widget.onShowingInput?.call();
                },
                child: Text(
                  widget.inputShowing ? "弹幕输入中" : "请输入弹幕",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            if (isExpanded) hiSpace(width: 10),
            InkWell(
              onTap: () {
                var expanded = !isExpanded;
                setState(() {
                  isExpanded = expanded;
                });
                widget.onBarrageSwitch?.call(expanded);
              },
              child: Icon(
                Icons.live_tv_rounded,
                size: 20,
                color: isExpanded ? primary : Colors.grey,
              ),
            ),
          ],
        ));
  }
}
