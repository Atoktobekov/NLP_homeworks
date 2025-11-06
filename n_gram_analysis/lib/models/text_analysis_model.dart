class TextAnalysisResult {
  final Map<String, int> wordFreq;
  final Map<String, int> bigramFreq;
  final Map<String, int> trigramFreq;

  TextAnalysisResult({
    required this.wordFreq,
    required this.bigramFreq,
    required this.trigramFreq,
  });
}
