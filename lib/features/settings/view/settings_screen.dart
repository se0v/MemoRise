import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkModeEnabled,
            onChanged: (value) {
              setState(() {
                _isDarkModeEnabled = value;

                if (_isDarkModeEnabled) {
                } else {}
              });
            },
          ),
          ListTile(
            title: const Text('E-mail: seovulf@gmail.com\nTelegram: @seovulf'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
