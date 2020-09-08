import 'package:flutter/material.dart';

import '../widgets/cartList.dart';
import '../widgets/ContactForm.dart';

class ContactUsPage extends StatelessWidget {
  static const routeName = '/contactus';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.194 * width),
      body: Container(
        padding: EdgeInsets.only(top: 0.041 * height),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 0.041 * height),
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
