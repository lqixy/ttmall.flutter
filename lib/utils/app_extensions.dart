import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime? convertToDateTime() {
    if (isEmpty) return null;

    String year = substring(0, 4);
    String month = substring(4, 6);
    String day = substring(6, 8);
    String hour = substring(8, 10);
    String minute = substring(10, 12);
    String second = substring(12, 14);

    return DateTime.parse('$year-$month-$day $hour:$minute:$second');
  }

  String hidePhoneNumber() {
    if (length < 11) {
      return '';
    }

    return replaceRange(3, 7, '****');
  }

  String hideIdCard() {
    if (length < 18) {
      return '';
    }

    return replaceRange(6, 14, '********');
  }

  String getContent(String pattern) {
    if (isEmpty) {
      return '';
    }
    var index = indexOf(pattern);
    return substring(index + 1);
  }

  int convertToInt() {
    if (isEmpty) {
      return 0;
    }

    var result = int.tryParse(this);
    return result ?? 0;
  }

  double convertToDouble() {
    if (isEmpty) {
      return 0;
    }
    var result = double.tryParse(this);
    return result ?? 0;
  }

  bool isAllEnglish() {
    for (var codePoint in runes) {
      if (!_isEnglishCodePoint(codePoint)) {
        return false;
      }
    }
    return true;
  }

  bool _isEnglishCodePoint(int codePoint) {
    return ((codePoint >= 0x41 && codePoint <= 0x5a) ||
        (codePoint >= 0x61 && codePoint <= 0x7a));
  }

  bool isValidPhoneNumber() {
    if (isEmpty || length != 11) {
      return false;
    }
    RegExp regExp = RegExp(
      r'^1[3456789]\d{9}$',
      caseSensitive: true,
      multiLine: false,
    );
    return regExp.hasMatch(this);
  }
}

extension StringNullExtension on String? {
  /// 隐藏手机号
  /// ```
  /// 18888888888 -> 188****8888
  /// ```
  String hidePhoneNumber() {
    if (this == null || this!.length < 11) {
      return '';
    }

    return this!.hidePhoneNumber();
  }

  String hideIdCard() {
    if (this == null || this!.length < 18) {
      return '';
    }
    return this!.hideIdCard();
  }

  String getContent(String pattern) {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return this!.getContent(pattern);
  }

  int convertToInt() {
    if (this == null || this!.isEmpty) {
      return 0;
    }
    return this!.convertToInt();
  }

  double convertToDouble() {
    if (this == null || this!.isEmpty) {
      return 0;
    }
    return this!.convertToDouble();
  }

  bool isAllEnglish() {
    if (this == null || this!.isEmpty) {
      return false;
    }
    return this!.isAllEnglish();
  }

  bool isValidPhoneNumber() {
    if (this == null || this!.isEmpty) {
      return false;
    }

    return this!.isValidPhoneNumber();
  }

  DateTime? convertToDateTime() {
    if (this == null || this!.isEmpty) {
      return null;
    }
    return this!.convertToDateTime();
  }
}

extension IntExtension on int {}

extension DateTimeExtension on DateTime? {
  String convertToString({String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    if (this == null) return '';

    return DateFormat(pattern).format(this!);
  }
}
