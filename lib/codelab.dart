// https://flutter-io.cn/docs/codelabs/dart-cheatsheet

String upperCaseIt(String str) {
  // Try conditionally accessing the `toUpperCase` method here.
  // 要保护可能会为空的属性的正常访问，请在点（.）之前加一个问号（?）。
  return str?.toUpperCase();
}

// Assign this a list containing 'a', 'b', and 'c' in that order:
final aListOfStrings = ['a', 'b', 'c'];

// Assign this a set containing 3, 4, and 5:
final aSetOfInts = {3, 4, 5};

// Assign this a map of String to int so that aMapOfStringsToInts['myKey'] returns 12:
final aMapOfStringsToInts = {'myKey': 12};

// Assign this an empty List<double>:
final anEmptyListOfDouble = <double>[];

// Assign this an empty Set<String>:
final anEmptySetOfString = <String>{};

// Assign this an empty Map of double to int:
final anEmptyMapOfDoublesToInts = <double, int>{};