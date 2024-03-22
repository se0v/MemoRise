import 'package:flutter/material.dart';
import 'package:memorise/local_notifications.dart';

class AnotherPage extends StatelessWidget {
  final String payload;
  const AnotherPage({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note Title")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Center(child: Text(payload)),
      ),
      floatingActionButton: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.green,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            sendSecondNotification();
            Navigator.pop(context);
          },
          child: const SizedBox(
            width: 120.0,
            height: 48.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Repeated ',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void sendSecondNotification() {
    LocalNotifications.showSecondNotifications(
        title: "Repeat again",
        body: "Second repetition",
        payload: "This is a TOYOTA");
  }
}
