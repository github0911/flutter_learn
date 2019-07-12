import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'cupertino_text_field.dart';


class ScaffoldWidget extends StatefulWidget {
  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var footerButton = List<Widget>();
    final _nameController = TextEditingController();
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
              keyboardType: TextInputType.text,
              controller: _nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//              icon: Icon(Icons.text_fields),
                labelText: "请输入用户名",
//                helperText: "只能输入中文",
              ),
              autofocus: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                WhitelistingTextInputFormatter(RegExp(r'[\u4e00-\u9fa5]+')),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: Colors.black,
              indent: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "请输入手机号",
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                suffixIcon: Icon(Icons.text_fields),
//                icon: Icon(Icons.text_fields),
//                labelText: "请输入手机号",
//                helperText: "请输入您使用的手机号",
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
            Divider(
              height: 1,
              color: Colors.black,
              indent: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '请输入验证码',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 20, 20, 10),
                  //              icon: Icon(Icons.text_fields),
                  //                labelText: "请输入验证码",
                  //                labelStyle: TextStyle(fontSize: 20, ),
                ),
                autofocus: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  WhitelistingTextInputFormatter(RegExp(r'\d+')),
                ],
              ),
              decoration: BoxDecoration(
                  // 下滑灰色，宽度1像素
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            ),
//            Divider(
//              height: 1,
//              color: Colors.black,
//              indent: 20,
//            ),
            SizedBox(
              height: 80,
            ),
            ButtonBar(
              //按钮显示位置 默认MainAxisAlignment.end
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.grey,
                  colorBrightness: Brightness.dark,
                  child: Text('取消'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  onPressed: () {
                    _nameController.clear();
                    _phoneController.clear();
                    _codeController.clear();
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  //按钮主题
                  colorBrightness: Brightness.dark,
                  child: Text('登录'),
//                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  onPressed: () {
//                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '聊天',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
//                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Expanded(
                  //富文本
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return new CupertinoTextFieldRoute();
                      }));
                      showToast("RichText");
                    },
                    onLongPress: () {
                      showBottomSheet();
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.red),
                        text: 'Hello ',
//                      style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'bold',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          TextSpan(
                              text: ' world!',
                              style: TextStyle(color: Colors.lightGreen)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.contact_mail,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),

        //设置floatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              //日历控件
//              DatePicker.showDatePicker(context,
//                  showTitleActions: true,
//                  minTime: DateTime(2019, 7, 3),
//                  maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
//                showToast('date ---> $date');
//              }, currentTime: DateTime.now(), locale: LocaleType.zh);
              //底部弹框
              showBottomSheet();
//              showModalBottomSheet(
//                  context: context,
//                  builder: (BuildContext context) {
//                    return Container(
//                      height: 500,
//                      width: 300,
//                      child: Image.asset("assets/ic_launcher.png"),
////                      child: Image.network(
////                          "https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png"),
//                    );
//                  });
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

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            width: 300,
            child: Image.asset("assets/ic_launcher.png"),
//                      child: Image.network(
//                          "https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png"),
          );
        });
  }
}
