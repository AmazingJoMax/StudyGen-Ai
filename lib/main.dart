import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readme/pages/start_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('books');
  var status = await Permission.storage.status;
  if (!status.isGranted) await Permission.storage.request();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'StudyCraft Ai',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: StartPage());
  }
}
