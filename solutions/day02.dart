import '../utils/index.dart';

class Subset {
  const Subset({required this.red, required this.green, required this.blue});

  factory Subset.fromString(String source) {
    final redRegex = RegExp(r'(\d+) red');
    final greenRegex = RegExp(r'(\d+) green');
    final blueRegex = RegExp(r'(\d+) blue');

    final red = redRegex.firstMatch(source)?.group(1);
    final green = greenRegex.firstMatch(source)?.group(1);
    final blue = blueRegex.firstMatch(source)?.group(1);

    return Subset(
      red: int.tryParse(red ?? '') ?? 0,
      green: int.tryParse(green ?? '') ?? 0,
      blue: int.tryParse(blue ?? '') ?? 0,
    );
  }

  final int red;
  final int green;
  final int blue;

  int power() {
    return red * green * blue;
  }

  @override
  String toString() {
    return '(${red}r,${green}g,${blue}b)';
  }
}

class Game {
  const Game({required this.id, required this.subsets});

  factory Game.fromString(String source) {
    final split = source.split(':');
    final id = int.tryParse(split.first.split(' ').lastOrNull ?? '') ?? 0;
    final subsets = split.last
        .split(';')
        .map(
          (e) => Subset.fromString(e.trim()),
        )
        .toList();

    return Game(id: id, subsets: subsets);
  }

  final int id;
  final List<Subset> subsets;

  int get maxRed => subsets.map((e) => e.red).max;
  int get maxGreen => subsets.map((e) => e.green).max;
  int get maxBlue => subsets.map((e) => e.blue).max;

  bool isPossibleWith({
    required int red,
    required int green,
    required int blue,
  }) {
    return maxRed <= red && maxGreen <= green && maxBlue <= blue;
  }

  int get power {
    return Subset(red: maxRed, green: maxGreen, blue: maxBlue).power();
  }

  @override
  String toString() {
    return 'Game $id: $subsets';
  }
}

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<Game> parseInput() {
    return input.getPerLine().map(Game.fromString).toList();
  }

  @override
  int solvePart1() {
    final games = parseInput();
    return games
        .where(
          (e) => e.isPossibleWith(red: 12, green: 13, blue: 14),
        )
        .map((e) => e.id)
        .sum;
  }

  @override
  int solvePart2() {
    final games = parseInput();
    return games.map((e) => e.power).sum;
  }
}
