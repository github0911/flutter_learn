import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

///流式布局
class WrapLayoutRoute extends StatelessWidget {
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
              onDeleted: () {},
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('3'),
              ),
            ),
            Chip(
              label: Text('four'),
              deleteIconColor: Colors.red,
              onDeleted: () {},
              deleteIcon: Icon(Icons.delete),
              avatar: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('4'),
              ),
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
          if (_lastPressedAt == null
              || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
            showToast('再按一次，退出应用', radius: 0);
            // 不出栈
            return false;
          }
          // 出栈
          return true;
        });
  }
}
