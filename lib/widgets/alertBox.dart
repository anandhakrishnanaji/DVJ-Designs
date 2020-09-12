import 'package:flutter/material.dart';

class Alertbox extends StatelessWidget {
  final content;
  Alertbox(this.content);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: content,
      actions: <Widget>[FlatButton(onPressed: null, child: Text('OK'))],
    );
  }
}
