import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/model/barrage_entity.dart';

class BarrageViewUtil {
  static barrageView(BarrageEntity model) {
    switch (model.type) {
      case 1:
        return _barrageType1(model);
    }
    return Text("${model.content}", style: TextStyle(color: Colors.white));
  }

  static _barrageType1(BarrageEntity model) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Text("${model.content}",
            style: TextStyle(color: Colors.deepOrangeAccent)),
      ),
    );
  }
}
