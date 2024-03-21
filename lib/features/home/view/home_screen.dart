import 'package:flutter/material.dart';
import 'package:memorise/another_page.dart';
import 'package:memorise/features/notes/notes.dart';
import 'package:memorise/features/settings/settings.dart';
import 'package:memorise/local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedPageIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

  // to listen to any notification clicked or not
  listenToNotifications() {
    debugPrint("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() => _selectedPageIndex = value);
        },
        children: const [
          NotesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }

  void _openPage(int index) {
    setState(() => _selectedPageIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
