import 'package:flutter/material.dart';
import 'package:n_gram_analysis/models/text_analysis_model.dart';
import 'package:n_gram_analysis/view/widgets/charts_view.dart';

class ResultsWidget extends StatelessWidget {
  final TextAnalysisResult result;
  const ResultsWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FrequencyChart(title: 'Word Frequency', data: result.wordFreq),
        FrequencyChart(title: 'Bigrams', data: result.bigramFreq),
        FrequencyChart(title: 'Trigrams', data: result.trigramFreq),
      ],
    );
  }
}
