enum SearchType {
  typical,
  allWords,
  anyWords;

  static SearchType fromString(String map) {
    return SearchType.values.where((e) => e.toString() == map).firstOrNull ??
        SearchType.typical;
  }
}
