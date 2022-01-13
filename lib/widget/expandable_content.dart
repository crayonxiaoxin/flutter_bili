import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_entity.dart';
import 'package:flutter_bili/util/view_util.dart';

/// 可展开的 widget
class ExpandableContent extends StatefulWidget {
  final HomeVideo? videoMo;

  const ExpandableContent({Key? key, required this.videoMo}) : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false;

  // 用来管理动画
  AnimationController? _controller;
  Animation<double>? _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(microseconds: 200), vsync: this);
    _heightFactor = _controller?.drive(_easeInTween);
    _controller?.addListener(() {
      print(_heightFactor?.value ?? "");
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _buildDesc(),
          Padding(padding: EdgeInsets.only(bottom: 8)),
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            widget.videoMo?.title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            size: 16,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  _buildInfo() {
    var dateStr = widget.videoMo?.createTime;
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.videoMo?.view ?? 0),
        Padding(padding: EdgeInsets.only(right: 10)),
        ...smallIconText(Icons.list_alt, widget.videoMo?.reply ?? 0),
        Padding(padding: EdgeInsets.only(right: 10)),
        Text(
          "    $dateStr",
          style: style,
        )
      ],
    );
  }

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  _buildDesc() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var child = _expand
        ? Text(
            widget.videoMo?.desc ?? "",
            style: style,
          )
        : null;
    return AnimatedBuilder(
      animation: _controller!.view,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Align(
            heightFactor: _heightFactor?.value,
            alignment: Alignment.topLeft,
            child: Container(
              child: child,
              padding: EdgeInsets.only(top: 8),
            ));
      },
    );
  }
}
