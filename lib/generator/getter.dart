import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Getter {
  final apiKey = dotenv.env['API_KEY'];

  Future<String?> getToc(String topic) async {
    String firstPrompt =
        'generate a table of content for a textbook on $topic and show only the result in unformatted json with a structure like [{"chapter": "Chapter title", sections: ["Section 1", "Section 2", ...]}].';
    String? toc = await Getter().get(firstPrompt);

    return toc;
  }

  Future<String?> getContent(String section) async {
    String prompt = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int detailLevel = prefs.getInt('detailLevel') ?? 1;
    switch (detailLevel) {
      case 1:
        prompt =
            'Discuss the section: "$section" briefly, highlighting the main points. And for the headings use heading 3';
      case 2:
        prompt =
            'Explain the section: "$section" in a clear and concise manner, providing enough detail to understand the core concepts but without going into excessive depth. And for the headings use heading 3';
      case 3:
        prompt =
            'Discuss the section: "$section" in high detail, providing in-depth explanations of the key concepts and a comprehensive analysis if needed. And for the headings use heading 3';
      default:
        'Explain the section: "$section" in a clear and concise manner, providing enough detail to understand the core concepts but without going into excessive depth. And for the headings use heading 3';
    }
    String? sectionContent = await Getter().get(prompt);

    return sectionContent;
  }

  Future<String?> get(prompt) async {
    if (apiKey == null) {
      exit(1);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int generativeModel =
        prefs.getInt('generativeModel') ?? 1; // Default to 1 if not set

    String modelType;
    switch (generativeModel) {
      case 1:
        modelType = 'gemini-1.5-flash-latest';
        break;
      case 2:
        modelType = 'gemini-1.5-pro-latest';
        break;

      default:
        modelType = 'gemini-1.5-flash-latest';
    }
    final model = GenerativeModel(
      model: modelType,
      apiKey: apiKey!,
    );

    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      print('Failed to generate content: $e');
      return null;
    }
  }
}
