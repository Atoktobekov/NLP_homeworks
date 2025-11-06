class TextRepository {
  List<String> cleanAndTokenize(String text, Set<String> stopWords) {
    final cleaned = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-zа-яёğüşöçıi0-9\s]', caseSensitive: false), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty && !stopWords.contains(w))
        .toList();
    return cleaned;
  }

  Map<String, int> countNGrams(List<String> words, int n) {
    final Map<String, int> freq = {};
    for (int i = 0; i <= words.length - n; i++) {
      final ngram = words.sublist(i, i + n).join(' ');
      freq[ngram] = (freq[ngram] ?? 0) + 1;
    }
    return freq;
  }
}
