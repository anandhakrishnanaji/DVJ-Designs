import 'package:flutter/material.dart';

import '../widgets/cartList.dart';
import '../widgets/ContactForm.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[Text('Contact Us'), CartList(), ContactForm()],
        ),
      ),
    );
  }
}
