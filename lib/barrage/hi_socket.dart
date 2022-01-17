import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/const.dart';
import 'package:flutter_bili/http/dao/login_dao.dart';
import 'package:flutter_bili/model/barrage_entity.dart';
import 'package:web_socket_channel/io.dart';

/// 负责与后端进行 webSocket 通信
class HiSocket implements ISocket {
  /// 接口地址
  static const _URL = "wss://api.devio.org/uapi/fa/barrage/";

  /// 心跳超时秒数，根据服务器实际 timeout，这里 ngnix 默认 60s
  int _pingInterval = 50;

  IOWebSocketChannel? _webSocketChannel;
  ValueChanged<List<BarrageEntity>>? _callback;

  @override
  void close() {
    _webSocketChannel?.sink.close();
  }

  @override
  ISocket listen(ValueChanged<List<BarrageEntity>>? callback) {
    _callback = callback;
    return this;
  }

  @override
  ISocket open(String? vid) {
    _webSocketChannel = IOWebSocketChannel.connect(_URL + "$vid",
        headers: _headers(), pingInterval: Duration(seconds: _pingInterval));
    _webSocketChannel?.stream.handleError((e) {
      print("socket连接发生错误: $e");
    }).listen((message) {
      _handleMessage(message);
    });
    return this;
  }

  /// 发送信息
  @override
  ISocket send(String? message) {
    _webSocketChannel?.sink.add(message);
    return this;
  }

  /// 设置请求头校验
  _headers() {
    Map<String, dynamic> headers = {
      Const.authTokenKey: Const.authToken,
      Const.courseFlagKey: Const.courseFlag,
    };
    // 需要登录
    headers[LoginDao.KEY_BOARDING_PASS] = LoginDao.getBoardingPass();
    return headers;
  }

  /// 处理服务端的返回
  void _handleMessage(message) {
    print("socket received: $message");
    var result = BarrageEntity.fromJsonString(message);
    _callback?.call(result);
  }
}

abstract class ISocket {
  /// 与服务器建立连接
  ISocket open(String? vid);

  /// 发送弹幕
  ISocket send(String? message);

  /// 关闭连接
  void close();

  /// 接收弹幕
  ISocket listen(ValueChanged<List<BarrageEntity>>? callback);
}
