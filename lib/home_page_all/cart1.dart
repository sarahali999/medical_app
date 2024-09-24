import 'package:flutter/material.dart';

class cart1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text('العلاج المستمر'),
      ),
      body: Center(
        child: Text(
          'محتوى صفحة العلاج المستمر',
          style: TextStyle(),
        ),
      ),
    );
  }
}