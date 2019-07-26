import 'package:flutter/material.dart';

///弹性布局
class FlexLayoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Container(
            width: double.infinity,
            height: 20,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  height: 30,
                  color: Colors.red,
                )),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    )),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
