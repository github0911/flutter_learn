import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'scaffold_widget.dart';
import 'progress_indicator.dart';
import 'package:flutter_app/widget/head_widget.dart';

///流式布局
class WrapLayoutRoute extends StatelessWidget {
  static const jumpPlugin = const MethodChannel("com.xinyan.jump/plugin");

  /// 跳转原生webView
  Future<Null> _jumpNativeWebView() async {
    String result = await jumpPlugin.invokeMethod("webView");
    showToast(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
//          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 10,
          runSpacing: 4,
          alignment: WrapAlignment.spaceAround,
          children: <Widget>[
            Chip(
              label: Text('one'),
              onDeleted: () {
                _jumpNativeWebView();
              },
              avatar: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text('1'),
              ),
            ),
            Chip(
              label: Text('two'),
              avatar: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Text('2'),
              ),
            ),
            Chip(
              label: Text('three'),
              onDeleted: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return new ProgressIndicatorRoute();
                }));
              },
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('3'),
              ),
            ),
            Chip(
              label: Text('four'),
              deleteIconColor: Colors.red,
              onDeleted: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new ScaffoldWidget();
                }));
              },
              deleteIcon: Icon(Icons.delete),
              avatar: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('4'),
              ),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation(Colors.redAccent[400]),
              ),
            ),
            SizedBox(
              height: 28,
              width: 28,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation(Colors.grey[400]),
                  ),
                  Text('x'),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Transform.rotate(
                // 旋转 rotate
                child: Text('Hello Flutter'),
                angle: math.pi / 2,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              child: Transform.translate(
                // 平移
                child: Text('translate'),
                offset: Offset(-10, 0),
              ),
            ),
            DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                    scale: 1.5, //放大到1.5倍
                    child: Text("Hello world"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Transform.scale(
                        scale: 1.5, child: Text("Hello world"))),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 3, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              color: Colors.deepOrange,
              child: Text('Hello Flutter'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.deepOrange,
              child: Text('Hello Flutter'),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 60),
              constraints: BoxConstraints.tightFor(width: 180, height: 100),
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: 0.98,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.orange[300],
                        offset: Offset(2, 2),
                        blurRadius: 3),
                  ]),
              transform: Matrix4.rotationZ(0.2),
              alignment: Alignment.center,
              child: Text(
                '7-11',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            HeadWidget(
              name: 'headhead',
              hasNotice: true,
            ),
            RangeSlider(
              values: RangeValues(1, 1),
              min: 1,
              max: 100,
              onChanged: (RangeValues rangeValues) {},
            ),
          ],
        ),
      ],
    );
  }
}

class WrapWillPopScopeLayoutRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WrapWillPopScopeLayoutRouteState();
  }
}

class WrapWillPopScopeLayoutRouteState
    extends State<WrapWillPopScopeLayoutRoute> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: WrapLayoutRoute(),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            showToast('再按一次，退出应用', radius: 0);
            _lastPressedAt = DateTime.now();
            // 不出栈
            return false;
          }
          // 出栈
          return true;
        });
  }
}
