import 'package:n_gram_analysis/models/text_analysis_model.dart';
import 'package:n_gram_analysis/repositories/text_repository.dart';

class TextAnalysisController {
  final TextRepository _repository = TextRepository();

  static final _stopWords = {
    'en': {'the', 'a', 'and', 'is', 'in', 'of', 'to', 'it'},
    'ru': {'и', 'в', 'на', 'с', 'что', 'не', 'это', 'как'},
    'tr': {'ve', 'bir', 'bu', 'için', 'de', 'da', 'ile'},
  };

  TextAnalysisResult analyzeText(String text, String lang) {
    final stopWords = _stopWords[lang] ?? {};
    final words = _repository.cleanAndTokenize(text, stopWords);

    final wordFreq = _repository.countNGrams(words, 1);
    final bigramFreq = _repository.countNGrams(words, 2);
    final trigramFreq = _repository.countNGrams(words, 3);

    return TextAnalysisResult(
      wordFreq: wordFreq,
      bigramFreq: bigramFreq,
      trigramFreq: trigramFreq,
    );
  }
}
