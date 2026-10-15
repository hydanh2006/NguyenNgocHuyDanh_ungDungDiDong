class Vocab {
  String word;
  String meaning;

  Vocab({required this.word, required this.meaning});

  String toFileString() {
    return "$word|$meaning";
  }

  static Vocab fromString(String line) {
    final parts = line.split("|");
    if (parts.length >= 2) {
      return Vocab(word: parts[0], meaning: parts[1]);
    }
    return Vocab(word: "", meaning: "");
  }
}
