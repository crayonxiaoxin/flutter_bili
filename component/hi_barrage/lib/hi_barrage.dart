library hi_barrage;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'barrage_entity.dart';
import 'barrage_item.dart';
import 'barrage_view_util.dart';
import 'hi_socket.dart';
import 'i_barrage.dart';

/// 弹幕状态
enum BarrageStatus { play, pause }

/// 弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  final Map<String, dynamic> headers;

  const HiBarrage(
      {Key? key,
      this.lineCount = 4,
      required this.vid,
      required this.headers,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  HiSocket? _hiSocket;
  double _width = 0;
  double _height = 0;
  final List<BarrageItem> _barrageItemList = []; // 弹幕 widget 集合
  final List<BarrageEntity> _barrageModelList = []; // 弹幕 数据模型 集合
  int _barrageIndex = 0; // 第几条弹幕
  final Random _random = Random();
  BarrageStatus? _barrageStatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket(widget.headers);
    _hiSocket?.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    _hiSocket?.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          // 防止 Stack children 为空
          Container(),
          ..._barrageItemList,
        ],
      ),
    );
  }

  /// 处理消息，instant=true 立即发送
  void _handleMessage(List<BarrageEntity> modelList, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, modelList);
    } else {
      _barrageModelList.addAll(modelList);
    }
    // 收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    // 收到新的弹幕后播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
      return;
    }
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("barrage action: _play");
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(microseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        // 将要发送的弹幕从集合中剔除
        var tmp = _barrageModelList.removeAt(0);
        // 将弹幕添加到屏幕上
        addBarrage(tmp);
      } else {
        // 所有弹幕发送完毕
        print("end: ----- 所有弹幕发送完毕 -----");
        _timer?.cancel();
      }
    });
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    print("barrage action: _pause");
    // 清空屏幕上的弹幕
    _barrageItemList.clear();
    // 刷新
    setState(() {});
    // 取消计时器
    _timer?.cancel();
  }

  /// 添加弹幕
  void addBarrage(BarrageEntity model) {
    print("start: ${model.content}");
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var top = line * perRowHeight + widget.top + statusBarHeight;
    // 为每条弹幕生成唯一 id
    String id = "${_random.nextInt(10000)}:${model.content}";
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  @override
  void send(String? message) {
    if (message == null) return;
    _hiSocket?.send(message);
    _handleMessage([BarrageEntity.instance(content: message)]);
  }

  void _onComplete(id) {
    print("remove: $id");
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
