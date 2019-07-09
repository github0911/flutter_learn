import 'package:flutter/material.dart';

///list page
class ListPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'List page',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List page'),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int position) {
        return _getRowWithDecoration(position);
      }),
    );
  }

  Widget _getRowWithDivider(int position) {
    var children = <Widget>[
      Padding(
        padding: new EdgeInsets.all(10),
        child: Text('Divider $position'),
      ),
      Divider(
        height: 5,
        color: Colors.red,
      ),
    ];
    return Column(
      children: children,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _getRowWithDecoration(int position) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100])),
//        color: Colors.pink,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('BoxDecoration $position'),
      ),
    );
  }
}
