import 'package:flutter/material.dart';
import 'package:hi_base/adapt.dart';
import 'package:hi_base/view_util.dart';

class HiFlexibleHeader extends StatefulWidget {
  final String? name;
  final String? face;
  final ScrollController? controller;
  final double initialOffset; // 初始偏移
  final double minOffset; //最小偏移
  final double expandedHeight; // 可收缩区域的高度

  const HiFlexibleHeader(
      {Key? key,
      required this.name,
      required this.face,
      required this.controller,
      this.initialOffset = 30,
      this.expandedHeight = 160,
      this.minOffset = 10})
      : super(key: key);

  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static var appBarHeight = Adapt.paddingTop();
  double _bottom = 0;

  // 中间收缩部分的偏移
  double get offset {
    if (widget.controller?.hasClients == false) return widget.initialOffset;
    var currentPosition = widget.controller?.position.pixels ?? 0;
    if (currentPosition > 0) {
      // 总共可以移动的距离
      var totalDistance =
          widget.expandedHeight - appBarHeight - widget.initialOffset;
      // 偏移的系数
      var factor = (1 - (currentPosition / totalDistance));
      // 最终偏移
      var tmp = widget.initialOffset * factor;
      return tmp < 0 ? 0 : tmp;
    } else {
      return widget.initialOffset;
    }
  }

  get listener => () {
        setState(() {
          _bottom = offset;
        });
      };

  @override
  void initState() {
    super.initState();
    _bottom = widget.initialOffset;
    widget.controller?.addListener(listener);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHead();
  }

  _buildHead() {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: _bottom + widget.minOffset),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name ?? "",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
