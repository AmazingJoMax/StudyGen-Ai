import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:readme/database.dart';
import 'package:readme/file_handler.dart';
import 'package:readme/pages/read_page.dart';
import 'package:readme/utils/colors.dart';
import 'package:readme/utils/drawer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Database db = Database();
  FileHandler fileHandler = FileHandler();
  final _books = Hive.box('books');
  SampleItem? selectedItem;
  void snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  void initState() {
    if (_books.get("BOOKS") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void share(book) {
    fileHandler.shareFile(book);
  }

  void convert(List<String> book) {
    fileHandler.convertToPDF(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Library"),
          backgroundColor: AppColor.darkPrimary,
          foregroundColor: AppColor.white,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        drawer: const AppDrawer(),
        body: ListView.builder(
          itemCount: db.books.length,
          itemBuilder: (context, index) {
            final book = db.books[index];
            final topic = book[0];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReadPage(
                            book: book,
                          )));
                },
                title: Text(topic.toString()),
                trailing: PopupMenuButton<SampleItem>(
                  initialValue: selectedItem,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedItem = item;
                      switch (item) {
                        case SampleItem.convert:
                          convert(book);
                          snackBar("${book[0]} saved to Documents");
                          break;
                        case SampleItem.delete:
                          db.delete(index);
                          snackBar("${book[0]} deleted");
                          break;
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.convert,
                      child: Text('Save as PDF'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.delete,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

enum SampleItem { convert, delete }
