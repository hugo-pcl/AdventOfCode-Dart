extension RegExpExtension on RegExp {
  Iterable<String> allOverlappingStringMatches(String input) {
    final matches = <String>[];
    var index = 0;
    var match = allMatches(input, index).firstOrNull;

    while (match != null) {
      matches.add(match.group(0)!);
      index = match.start + 1;
      match = allMatches(input, index).firstOrNull;
    }
    return matches;
  }
}
