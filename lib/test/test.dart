import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_app/common/text_util.dart';
import 'package:flutter_app/common/LocalStorage.dart';


//
//main() {
//  bool flag = TextUtil.isEmpty("");
//  print(flag);
//
//  var text = TextUtil.formatSpace4("13699999999");
//  print(text);
//
//  text = TextUtil.formatPhoneNo("13699999999");
//  print(text);
//
//  text = TextUtil.reverse("13699999999");
//  print(text);
//
//  text = TextUtil.hideNumber("13688888888");
//  print(text);
//
//  String text = TextUtil.formatCurrencyNo("2999988");
//  print(text);
//  var key = "key_bool";
//  LocalStorage.saveBool(key, true);
//  print(LocalStorage.getBool(key));
//}

main() async {
  Socket socket = await Socket.connect('192.168.1.99', 1024);
  print('connected');

  // listen to the received data event stream
  socket.listen((List<int> event) {
    print(utf8.decode(event));
  });

  // send hello
  socket.add(utf8.encode('hello'));

  // wait 5 seconds
  await Future.delayed(Duration(seconds: 5));

  // .. and close the socket
  socket.close();
}