import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomMultiRenderPage extends StatefulWidget {
  @override
  CustomMultiRenderPageState createState() {
    return CustomMultiRenderPageState();
  }
}

class CustomMultiRenderPageState extends State<CustomMultiRenderPage> {
  List customLayoutId = ["0", "1", "2", "3", "4", "5"].toList();

  @override
  Widget build(BuildContext context) {
    double childSize = 66;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          width: width,
          height: width,
          child: CustomMultiChildLayout(
            delegate: CircleLayoutDelegate(customLayoutId,
                childSize: Size(childSize, childSize),
                center: Offset(MediaQuery.of(context).size.width / 2,
                    MediaQuery.of(context).size.width / 2)),
            children: <Widget>[
              for (var item in customLayoutId)
                LayoutId(id: item, child: ContentItem(item, childSize)),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          color: Colors.amberAccent,
          onPressed: () {
            setState(() {
              customLayoutId.add("${customLayoutId.length}");
            });
          },
          child: Text(
            "加",
            style: TextStyle(color: Colors.white),
          ),
        ),
        FlatButton(
          color: Colors.indigoAccent,
          disabledColor: Colors.grey,
          onPressed: () {
            setState(() {
              if (customLayoutId.length > 1) {
                customLayoutId.removeLast();
              }
            });
          },
          child: Text(
            "减",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class CircleLayoutDelegate extends MultiChildLayoutDelegate {
  List<String> customLayoutId;

  Offset center;

  Size childSize;

  CircleLayoutDelegate(this.customLayoutId,
      {this.center = Offset.zero, this.childSize});

  @override
  void performLayout(Size size) {
    for (var item in customLayoutId) {
      if (hasChild(item)) {
        double r = 100;
        int index = int.parse(item);
        double step = 360 / customLayoutId.length;

        double hd = (2 * math.pi / 360) * step * index;

        var x = center.dx + math.sin(hd) * r;

        var y = center.dy - math.cos(hd) * r;

        childSize ??= Size(size.width / customLayoutId.length,
            size.height / customLayoutId.length);

        ///设置 child 大小
        layoutChild(item, BoxConstraints.loose(childSize));

        final double centerX = childSize.width / 2.0;

        final double centerY = childSize.height / 2.0;

        var result = new Offset(x - centerX, y - centerY);

        positionChild(item, result);
      }
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

class ContentItem extends StatelessWidget {
  String text;
  double childSize;

  ContentItem(this.text, this.childSize);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(childSize / 2.0),
      child: InkWell(
        radius: childSize / 2.0,
        customBorder: CircleBorder(),
        onTap: () {},
        child: Container(
          width: childSize,
          height: childSize,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
