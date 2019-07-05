import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String msg = "文本不能为空！";
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve Text Input"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (myController.text?.length != 0) {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      myController.text,
                      textAlign: TextAlign.center,
                    ),
                  );
                });
          } else {
            showToast("需要隐藏的toast消息",
                duration: Duration(seconds: 5), radius: 0);
            //普通的文本提示
//            showToast("文本不能为空！");
            _showCustomWidgetToast(msg);
          }
        },
        tooltip: 'Show text value',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  void _showCustomWidgetToast(String msg) {
    var w = Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        color: Colors.black.withOpacity(0.7),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            ),
//            Icon(Icons.text_fields, color: Colors.white),
            Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
            Image.network(
              'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
              fit: BoxFit.contain,
              width: 150.0,
              height: 80.0,
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      showToastWidget(w, duration: Duration(seconds: 2), onDismiss: () {
        print("dismiss toast");
      }, dismissOtherToast: true);
    });
//    showToastWidget(w, duration: Duration(seconds: 1), onDismiss: () {
//      print("dismiss toast");
//    }, dismissOtherToast: true);
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }
}
