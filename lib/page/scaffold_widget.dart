import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldWidget extends StatefulWidget {
  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var footerButton = List<Widget>();
    final _phoneController = TextEditingController();
    final _codeController = TextEditingController();

    footerButton
      ..add(Icon(
        Icons.accessibility_new,
        color: Colors.red,
        size: 30,
      ))
      ..add(Icon(
        Icons.account_box,
        color: Colors.blue,
        size: 30,
      ))
      ..add(Icon(
        Icons.contact_mail,
        color: Colors.yellow,
        size: 30,
      ));

    return Scaffold(
        //设置应用栏，显示在脚手架顶部
        appBar: AppBar(
          title: Text("Scaffold title"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _phoneController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//              icon: Icon(Icons.text_fields),
                labelText: "请输入手机号",
                helperText: "请输入您使用的手机号",
              ),
              autofocus: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                WhitelistingTextInputFormatter(RegExp(r'\d+')),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//              icon: Icon(Icons.text_fields),
                labelText: "请输入验证码",
              ),
              autofocus: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                WhitelistingTextInputFormatter(RegExp(r'\d+')),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('取消'),
//                  shape: BeveledRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
//                  ),
                  onPressed: () {
                    _phoneController.clear();
                    _codeController.clear();
                  },
                ),
                RaisedButton(
                  child: Text('登录'),
                  elevation: 8.0,
//                  shape: BeveledRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
//                  ),
                  onPressed: () {
//                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),

        //设置floatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 500,
                      width: 300,
                      child: Image.network(
                          "https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png"),
                    );
                  });
            });
          },
          tooltip: "setState",
          child: Icon(Icons.settings_backup_restore),
        ),
        //设置floatingActionButton的位置
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        persistentFooterButtons: footerButton,
        //控制界面内容 body 是否重新布局来避免底部被覆盖，比如当键盘显示的时候，重新布局避免被键盘盖住内容。
        resizeToAvoidBottomInset: false);
  }
}
