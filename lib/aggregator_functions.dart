library pivot_table;

class AggregatorFunctions {
  static int countAggregator(List<dynamic> values) {
    return values.length; // Count the number of occurrences
  }

  static int sumAggregator(List<dynamic> values) {
    return values.fold(0, (sum, item) => sum + (item is int ? item : 0));
  }
}
