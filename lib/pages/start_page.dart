import 'package:flutter/material.dart';
import 'package:readme/pages/about_page.dart';
import 'package:readme/pages/generate_page.dart';
import 'package:readme/pages/library_page.dart';
import 'package:readme/pages/settings_page.dart';
import 'package:readme/utils/colors.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class StartPage extends StatelessWidget {
  StartPage({super.key});
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/readme_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black54,
              Colors.black87,
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("What do you want to learn today?",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.white,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: IconButton.filled(
                                  icon: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (_inputController.text.isNotEmpty) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GeneratePage(
                                                      topic: _inputController
                                                          .text
                                                          .toTitleCase())));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Please enter a topic"),
                                      ));
                                    }
                                  }),
                            ),
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LibraryPage()));
                        },
                        child: const Text("Go To Library",
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ))
                ]),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()));
                    },
                    icon: const Icon(
                      color: AppColor.white,
                      Icons.info_outline_rounded,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                    },
                    icon: const Icon(
                      color: AppColor.white,
                      Icons.settings,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
