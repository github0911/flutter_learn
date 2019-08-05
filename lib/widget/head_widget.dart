import 'package:flutter/material.dart';

class HeadWidget extends StatefulWidget {
  final bool isCircle;
  final String name;
  final bool hasNotice;
  final String iconUrl;
  final bool isShowBorder;

  const HeadWidget(
      {this.name: "",
      this.isCircle: true,
      this.hasNotice: false,
      this.iconUrl,
      this.isShowBorder: false});

  @override
  HeadWidgetState createState() {
    return HeadWidgetState();
  }
}

class HeadWidgetState extends State<HeadWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _getIconWidget(widget.isCircle, widget.isShowBorder),
            _getNoticeWidget(widget.hasNotice),
          ],
        ),
        Container(
          alignment: Alignment.center,
          width: 50,
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(),
          ),
        ),
      ],
    );
  }

  Widget _getNoticeWidget(bool hasNotice) {
    Widget widget = SizedBox();
    if (hasNotice) {
      widget = Positioned(
          top: 2,
          right: 2,
          child: Container(
              width: 10,
              height: 10,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              ),
              padding: const EdgeInsets.all(1.0), // border width
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // border color
                shape: BoxShape.circle,
              )));
    }
    return widget;
  }

  Widget _getIconWidget(bool isCircle, bool isShowBorder) {
    Widget widget = SizedBox();
    if (isCircle) {
      widget = Container(
          width: 50,
          height: 50,
          child: CircleAvatar(
//            backgroundImage: NetworkImage(''),
            backgroundColor: Colors.blue,
            radius: 20,
          ),
          padding: _getBorderPadding(isShowBorder), // border width
          decoration: _getBoxDecoration(isShowBorder));
    } else {
      widget = Container(
          child: Image.network(''),
          padding: const EdgeInsets.all(1.0), // border width
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF), // border color
            shape: BoxShape.rectangle,
          ));
    }

    return widget;
  }

  EdgeInsets _getBorderPadding(bool isShowBorder) {
    return isShowBorder ? const EdgeInsets.all(1.0) : EdgeInsets.only();
  }

  BoxDecoration _getBoxDecoration(bool isShowBorder) {
    return isShowBorder
        ? BoxDecoration(
            color: Colors.pinkAccent, // border color
            shape: BoxShape.circle,
          )
        : BoxDecoration();
  }
}
