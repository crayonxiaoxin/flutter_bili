import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class BarrageSwitch extends StatefulWidget {
  /// 初始化时是否展开
  final bool initSwitch;

  /// 是否为输入中
  final bool inputShowing;

  /// 输入框回调
  final VoidCallback onShowingInput;

  /// 展开收起回调
  final ValueChanged onBarrageSwitch;

  const BarrageSwitch(
      {Key? key,
      this.initSwitch = true,
      this.inputShowing = false,
      required this.onShowingInput,
      required this.onBarrageSwitch})
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
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            if (isExpanded)
              InkWell(
                onTap: () {
                  widget.onShowingInput.call();
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 3, bottom: 3),
                  child: Text(
                    widget.inputShowing ? "弹幕输入中" : "点我发弹幕",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
            InkWell(
              onTap: () {
                var expanded = !isExpanded;
                setState(() {
                  isExpanded = expanded;
                });
                widget.onBarrageSwitch.call(expanded);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.live_tv_rounded,
                  size: 20,
                  color: isExpanded ? primary : Colors.grey,
                ),
              ),
            ),
          ],
        ));
  }
}
