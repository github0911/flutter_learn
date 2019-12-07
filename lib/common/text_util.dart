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
  static String reverse(String s) {
    if (isEmpty(s)) {
      return s;
    }
    StringBuffer sb = StringBuffer();
    var runes = s.runes.iterator..reset(s.length);
    while (runes.movePrevious()) {
      sb.writeCharCode(runes.current);
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

    /// 是否空白
  static bool isBlank(String s) {
    return s == null || s.trim().isEmpty;
  }

  /// 字符串不是空白
  static bool isNotBlank(String s) {
    return s != null && s.trim().isNotEmpty;
  }

  /// 字符串不为空
  static bool isNotEmpty(String s) {
    return s != null && s.isNotEmpty;
  }

  /// 不区分大小写判断是否相等
  static bool equalsIgnoreCase(String a, String b) {
    return (a == null && b == null) ||
        (a != null && b != null && a.toLowerCase() == b.toLowerCase());
  }
}
