import 'package:flutter/material.dart';

import '../widgets/cartList.dart';
import '../widgets/ContactForm.dart';

class ContactUsPage extends StatelessWidget {
  static const routeName = '/contactus';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            CartList(),
            ContactForm()
          ],
        ),
      ),
    );
  }
}
