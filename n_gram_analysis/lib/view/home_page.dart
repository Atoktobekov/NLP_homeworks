import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n_gram_analysis/controllers/text_controller.dart';
import 'package:n_gram_analysis/models/text_analysis_model.dart';
import 'widgets/results_widget.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextAnalysisController _analyzer = TextAnalysisController();
  TextAnalysisResult? _result;
  String _lang = 'en';

  void _processText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _result = _analyzer.analyzeText(text, _lang));
  }

  void _downloadTxt() {
    if (_result == null) return;

    final buffer = StringBuffer();
    buffer.writeln("=== WORD FREQUENCY ===");
    _result!.wordFreq.forEach((k, v) => buffer.writeln('$k: $v'));
    buffer.writeln("\n=== BIGRAMS ===");
    _result!.bigramFreq.forEach((k, v) => buffer.writeln('$k: $v'));
    buffer.writeln("\n=== TRIGRAMS ===");
    _result!.trigramFreq.forEach((k, v) => buffer.writeln('$k: $v'));

    final bytes = utf8.encode(buffer.toString());
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..download = "analysis_result.txt"
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("N-Gram Text Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _lang,
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text("English")),
                      DropdownMenuItem(value: 'ru', child: Text("Русский")),
                      DropdownMenuItem(value: 'tr', child: Text("Türkçe")),
                    ],
                    onChanged: (val) => setState(() => _lang = val ?? 'en'),
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: _processText,
                  child: const Text("Process"),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: _downloadTxt,
                  child: const Text("Download .txt"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        labelText: "Enter text here...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _result == null
                        ? const Center(child: Text("No analysis yet"))
                        : ResultsWidget(result: _result!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
