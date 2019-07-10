import 'package:flutter/material.dart';

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
