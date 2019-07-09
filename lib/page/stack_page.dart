import 'package:flutter/material.dart';
/// stack layout
class StackPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Stack page',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StackPage(),
    );
  }
}

class StackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //通过ConstrainedBox来确保Stack占满屏幕
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Hello Stack',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            color: Colors.red,
          ),
          Positioned(
            bottom: 18,
            child: Text('Bottom positioned', style: TextStyle(fontSize: 15)),
          ),
          Positioned(
            top: 30,
            child: Text(
              "Top positioned",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Positioned(
              right: 10,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  Text('first children',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(5),
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.print,
                        color: Colors.white,
                      ),
                      Text('children text',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ],
                  )
                ],
              )),
        ],
        alignment: Alignment.center,
      ),
    );
  }
}
