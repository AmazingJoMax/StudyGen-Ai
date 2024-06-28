import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key, required this.book});
  final List<String> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book[0]),
      ),
      body: Center(
        child: Markdown(data: book[1]),
      ),
    );
  }
}

