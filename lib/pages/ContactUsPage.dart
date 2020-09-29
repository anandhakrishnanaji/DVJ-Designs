import 'package:flutter/material.dart';

import '../widgets/cartList.dart';
import '../widgets/ContactForm.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Enquiry',
              style: TextStyle(fontSize: 0.041 * height),
              textAlign: TextAlign.center,
            ),
          ),
          CartList(),
          ContactForm()
        ],
      ),
    );
  }
}
