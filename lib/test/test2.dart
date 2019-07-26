import 'package:flutter_app/common/LocalStorage.dart';

main() {
  LocalStorage.saveBool("key_bool", true);
  print(LocalStorage.getBool("key_bool"));
}