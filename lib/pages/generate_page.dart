import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:readme/database.dart';
import 'package:readme/generator/generate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:readme/utils/colors.dart';
import 'package:readme/utils/drawer.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key, required this.topic});
  final String topic;

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  late Stream<Map<String, dynamic>> _stream;
  late StreamSubscription<Map<String, dynamic>> _streamSubscription;
  String _content = '';
  int _totalSectionsCount = 1;
  int _sectionsCount = 0;
  bool _firstDataReceived = false;
  Database db = Database();
  Toastification toast = Toastification();
  final _books = Hive.box('books');

  void saveContent(String fileName) {
    db.save(fileName, _content);
  }

  @override
  void initState() {
    super.initState();
    if (_books.get("BOOKS") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    _stream = Generator(widget.topic).generateContentStream();
    _streamSubscription = _stream.listen((data) {
      setState(() {
        _content += data['content'];
        _totalSectionsCount = data['sectionsCount'] + 1;
        _sectionsCount++;
        _firstDataReceived = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        drawer: const AppDrawer(),
        body: _firstDataReceived
            ? Markdown(data: _content)
            : const Center(
                child: SpinKitThreeBounce(
                color: AppColor.darkPrimary,
                size: 50.0,
              )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: _sectionsCount / _totalSectionsCount,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.bookmark_add_rounded),
            onPressed: () {
              final TextEditingController controller =
                  TextEditingController(text: widget.topic);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add to Library'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // const Text('Do you want to bookmark this page?'),
                        TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'File Name',
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          saveContent(widget.topic);
                          Navigator.pop(context);
                          toast.show(
                              context: context,
                              type: ToastificationType.success,
                              style: ToastificationStyle.flatColored,
                              title: Text("Successfully saved to Library"),
                              autoCloseDuration: const Duration(seconds: 4));
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}

Widget _chapterHeader(String chapter) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(chapter,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  );
}
