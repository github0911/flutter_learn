import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

///网络获取
class NetworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: NetworkBody(),
        )
    );
  }
}

class NetworkBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Quotation(
            url: 'https://quotes.rest/qod.json',
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Image.asset(
            "assets/ic_launcher.png",
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}

class Quotation extends StatefulWidget {
  Quotation({Key key, this.url}) : super(key: key);

  final String url;

  @override
  QuotationState createState() {
    return new QuotationState();
  }
}

class QuotationState extends State<Quotation> {
  String data = "加载中...";

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    final res = await http.get(widget.url);
    setState(() {
      data = _parseQuoteFromJson(res.body);
    });
  }

  String _parseQuoteFromJson(String jsonStr) {
    final jsonObject = json.decode(jsonStr);
    print(jsonObject);
    return jsonObject['contents']['quotes'][0]['title'];
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    // TODO: implement build
    return Text(
      data,
      textAlign: TextAlign.center,
    );
  }
}
