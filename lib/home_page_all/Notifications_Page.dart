import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(
          'This is the notifications page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
