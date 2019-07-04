import 'package:flutter_app/Bicycle.dart';
import 'dart:core';

class Bicycle {
  int cadence;
  int _speed = 1;

  // get 方法
  int get speed => _speed;
  int gear;

  Bicycle(this.cadence, this._speed, this.gear);

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => 'Bicycle: $_speed mph, $cadence cadence, $gear gear';
}

void main() {
  var bike = new Bicycle(2, 0, 1);
  bike.speedUp(155);
  print(bike.speed);
  print(bike);

  int lineCount = 1;
  try {
    assert(lineCount == null);
  } on Exception catch (e, s) {
    print('Unknown exception: $e \n$s');
  } on AssertionError catch (e, s) {
    print('AssertionError: $e \n$s');
  }

  int tempLimit = 10;

  int lowerLimit = 12;
  int upperLimit = 14;
  print(tempLimit.clamp(lowerLimit, upperLimit));
}
