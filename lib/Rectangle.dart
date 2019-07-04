import 'dart:math';

class Rectangle {
  Point origin;
  int width;
  int height;

  Rectangle({this.origin = const Point(0, 0), this.width = 0, this.height = 0});

  @override
  String toString() {
    return 'Origin ${origin.x} ${origin.y}, width $width, height $height';
  }
}

void main() {
  print(Rectangle());
  print(Rectangle(origin: const Point(1, 2), width: 10, height: 20));
  print(Rectangle(width: 100, height: 110));
  print(Rectangle(origin: const Point(11, 12)));
}