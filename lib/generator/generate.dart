import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'getter.dart';
import 'toc.dart';

class Generator {
  final String topic;

  Generator(this.topic);
  Future<List<Toc>> parseToc() async {
    var content = await Getter().getToc(topic);
    var jsonContent = jsonDecode(content!);
    return (jsonContent as List).map((json) => Toc.fromJson(json)).toList();
  }

  Stream<Map<String, dynamic>> generateContentStream() async* {
    var tocs = await parseToc();

    // Generate and yield the table of contents first
    int sectionsCount =
        tocs.fold(0, (prev, toc) => prev + toc.sections.length) + tocs.length;
    var tocContent = tocs
        .map((toc) =>
            '### ${toc.chapter}\n${toc.sections.map((section) => '- $section').join('\n')}')
        .join('\n\n');
    yield {
      'content': '## Table Of Contents \n $tocContent \n\n---\n\n',
      'sectionsCount': sectionsCount
    };
    for (var toc in tocs) {
      yield {
        'content': '## ${toc.chapter}\n\n',
        'sectionsCount': sectionsCount
      };
      for (var section in toc.sections) {
        var retryCount = 0;
        while (retryCount < 3) {
          // Retry up to 3 times
          try {
            var tempContent = await Getter().getContent(section);
            yield {'content': tempContent, 'sectionsCount': sectionsCount};
            break; // Break the loop if the operation succeeds
          } catch (e) {
            retryCount++;
            if (retryCount == 3) {
              // If all retries failed, rethrow the exception
              rethrow;
            }
            await Future.delayed(const Duration(
                seconds: 5)); // Wait for 5 seconds before retrying
          }
        }
      }
    }
  }

  void generate() async {
    var stream = generateContentStream();
    // Create a new file
    var file = File('books/${topic.replaceAll(' ', '_')}.md');

    // If the file doesn't exist, create it
    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    // Open the file for writing
    var sink = file.openWrite();

    // Listen to the stream
    stream.listen((content) {
      // Display the content on the screen
      print(content);

      // Write the content to the file
      sink.write(content);
    }, onError: (e) {
      print('An error occurred: $e');
    }, onDone: () {
      sink.close();
    });
  }
}
