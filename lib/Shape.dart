import 'dart:math';
import 'Rectangle.dart';

abstract class Shape {
  factory Shape(String type) {
    if (type == 'circle') {
      return Circle(2);
    }
    if (type == 'square') {
      return Square(2);
    }
    throw 'Can\'t create $type.';
  }

  num get area;
}

Shape shapeFactory(String type) {
  if (type == 'circle') {
    return Circle(2);
  }
  if (type == 'square') {
    return Square(2);
  }
  throw 'Can\'t create $type.';
}

class Circle implements Shape {
  final num radius;

  Circle(this.radius);

  @override
  num get area => pi * pow(radius, 2);
}

class Square implements Shape {
  final num side;

  Square(this.side);

  @override
  num get area => pow(side, 2);
}

class CircleMock implements Circle {
  num radius;
  num area;
}

String upperCaseIt(String str) {
  // Try conditionally accessing the `toUpperCase` method here.
  // 要保护可能会为空的属性的正常访问，请在点（.）之前加一个问号（?）。
  return str?.toUpperCase();
}

void main() {
  final circle = Shape('circle');
  final square = shapeFactory('square');
  print('circle area ' + circle.area.toString());
  print('square area ' + square.area.toString());
  print(upperCaseIt(null));
  print(Rectangle());
}
