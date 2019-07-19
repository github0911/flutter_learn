class TextUtil {
  static bool isEmpty(String text) {
    return text == null || text.isEmpty;
  }

  /// 每隔 x位 加 pattern
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text?.replaceAllMapped(new RegExp("(.{$digit})"), (Match match) {
      return "${match.group(0)}$pattern";
    });

    if (!isEmpty(text) && text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }

    return text;
  }

  static String formatSpace4(String text) {
    return formatDigitPattern(text);
  }

  /// 格式化手机号
  static String formatPhoneNo(String text) {
    var result = formatDigitPattern("*" + text);
    return result.length > 1 ? result.substring(1) : "";
  }

  /// 字符串反序
  static String reverse(String text) {
    if (isEmpty(text)) {
      return '';
    }
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }

  /// 分割字符串
  static List<String> split(String text, Pattern pattern,
      {List<String> defValue = const []}) {
    List<String> list = text?.split(pattern);
    return list ?? defValue;
  }

  static String hideNumber(String phoneNo,
      {int start = 3, int end = 7, String replacement = '****'}) {
    return phoneNo?.replaceRange(start, end, replacement);
  }

  /// 每隔 digit 位 增加 pattern， 从末尾开始
  /// 金额的处理 8888888 => 8,888,888
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: digit, pattern: pattern);
    temp = reverse(temp);
    return temp;
  }

  /// 格式化货币
  /// 8888888 => 8,888,888
  static String formatCurrencyNo(Object num) {
    return formatDigitPatternEnd(num?.toString(), digit: 3, pattern: ',');
  }
}
