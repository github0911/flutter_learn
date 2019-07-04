class Color {
  int red;
  int green;
  int blue;

  Color(this.red, this.green, this.blue);

  // Create a named constructor called "black" here:
  Color.black() {
    red = 0;
    green = 0;
    blue = 0;
  }
}

void main() {
  final black = Color.black();
  black.blue = 121;
  black.red = 123;
  print(black.red?.toString() + ' ' + black.blue.toString());
}