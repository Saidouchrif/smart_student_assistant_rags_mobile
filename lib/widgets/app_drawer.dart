import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../pages/about_page.dart';
import '../pages/chatbot_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Said Ouchrif"),
            accountEmail: const Text("saidouchrif16@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),

          ListTile(
            title: const Text("Profil"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          ),
          ListTile(
            title: const Text("Chatbot"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ChatbotPage()));
            },
          ),
          ListTile(
            title: const Text("À propos"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AboutPage()));
            },
          ),
          ListTile(
            title: const Text("Paramètres"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
