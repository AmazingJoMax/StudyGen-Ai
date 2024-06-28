import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  int _detailLevel = 2;
  int _generativeModel = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        const Divider(
          thickness: 1.0,
        ),
        ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(children: [
                        RadioListTile(
                            value: 1,
                            title: const Text("Low"),
                            groupValue: _detailLevel,
                            onChanged: (value) async {
                              setState(() {
                                _detailLevel = value!;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt('detailLevel', _detailLevel);
                              if (context.mounted) Navigator.pop(context);
                            }),
                        RadioListTile(
                            value: 2,
                            title: const Text("Medium"),
                            groupValue: _detailLevel,
                            onChanged: (value) async {
                              setState(() {
                                _detailLevel = value!;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt('detailLevel', _detailLevel);
                              if (context.mounted) Navigator.pop(context);
                            }),
                        RadioListTile(
                            value: 3,
                            title: const Text("High"),
                            groupValue: _detailLevel,
                            onChanged: (value) async {
                              setState(() {
                                _detailLevel = value!;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt('detailLevel', _detailLevel);
                              if (context.mounted) Navigator.pop(context);
                            }),
                        const Text(
                            "The higher the level, the longer the generation time.")
                      ]),
                    ),
                  );
                }));
          },
          title: const Text("Level Of Detail"),
          trailing: Text(_detailLevel == 1
              ? 'Low'
              : _detailLevel == 2
                  ? 'Medium'
                  : 'High'),
        ),
        const Divider(
          thickness: 1.0,
        ),
        ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(children: [
                        RadioListTile(
                            value: 1,
                            title: const Text("Gemini 1.5 flash"),
                            groupValue: _generativeModel,
                            onChanged: (value) async {
                              setState(() {
                                _generativeModel = value!;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt(
                                  'generativeModel', _generativeModel);
                              if (context.mounted) Navigator.pop(context);
                            }),
                        RadioListTile(
                            value: 2,
                            title: const Text("Gemini 1.5 pro"),
                            groupValue: _generativeModel,
                            onChanged: (value) async {
                              setState(() {
                                _generativeModel = value!;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt(
                                  'generativeModel', _generativeModel);
                              if (context.mounted) Navigator.pop(context);
                            }),
                      ]),
                    ),
                  );
                }));
          },
          title: const Text("Generative Model"),
          trailing: Text(
              _generativeModel == 1 ? 'Gemini 1.5 flash' : 'Gemini 1.5 pro'),
        ),
        const Divider(
          thickness: 1,
        )
      ]),
    );
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _generativeModel = prefs.getInt('generativeModel') ??
          1; // Use a default value if no value is saved
      _detailLevel = prefs.getInt('detailLevel') ??
          1; // Use a default value if no value is saved
    });
  }
}
