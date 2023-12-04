import '../utils/index.dart';
import '../utils/regex_util.dart';

enum Digit {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine;

  static Digit fromString(String digit) {
    return switch (digit) {
      '1' || 'one' => one,
      '2' || 'two' => two,
      '3' || 'three' => three,
      '4' || 'four' => four,
      '5' || 'five' => five,
      '6' || 'six' => six,
      '7' || 'seven' => seven,
      '8' || 'eight' => eight,
      '9' || 'nine' => nine,
      _ => throw Exception('Invalid digit: $digit'),
    };
  }

  /// Returns a tuple of two digits where the first one is the first digit
  /// found in the string and the second one is the last digit found in the
  /// string.
  static (Digit, Digit) fromLine(String source) {
    final digits = any.allOverlappingStringMatches(source);
    final digit1 = fromString(digits.first);
    final digit2 = fromString(digits.last);

    return (digit1, digit2);
  }

  static RegExp get any =>
      RegExp(r'[\d]|one|two|three|four|five|six|seven|eight|nine');

  int get asInt => index + 1;
}

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  int solvePart1() {
    return input
        .getPerLine()
        .map((e) => e.replaceAllMapped(RegExp(r'\D+'), (match) => ''))
        .where((element) => element.isNotEmpty)
        .map((e) => e.trim())
        .map((e) => '${e.codeUnits.first - 48}${e.codeUnits.last - 48}')
        .map(int.tryParse)
        .whereType<int>()
        .reduce((value, element) => value + element);
  }

  @override
  int solvePart2() {
    return input
        .getPerLine()
        .where((element) => element.isNotEmpty)
        .map(Digit.fromLine)
        .map((e) => '${e.$1.asInt}${e.$2.asInt}')
        .map(int.tryParse)
        .whereType<int>()
        .reduce((value, element) => value + element);
  }
}
