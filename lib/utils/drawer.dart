import 'package:flutter/material.dart';
import 'package:readme/pages/about_page.dart';
import 'package:readme/pages/library_page.dart';
import 'package:readme/pages/settings_page.dart';
import 'package:readme/pages/start_page.dart';
import 'package:readme/utils/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.darkPrimary,
            ),
            child: Center(
              child: Text(
                'StudyCraft Ai',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StartPage()));
            },
            title: const Text('Home'),
            leading: const Icon(Icons.home_filled),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LibraryPage()));
            },
            title: const Text('Library'),
            leading: const Icon(Icons.book),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
            title: const Text('About'),
            leading: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
    );
  }
}
