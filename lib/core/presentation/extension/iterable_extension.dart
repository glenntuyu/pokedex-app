extension IterableIntegerExtension on Iterable<int> {
  int get sum {
    var result = 0;
    for (var value in this) {
      result += value;
    }
    return result;
  }
}