import 'package:flutter/material.dart';

import './homePage.dart';

class OTPVerification extends StatefulWidget {
  static const routeName = '/otp';
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController pno = new TextEditingController();
  bool ispnoerror = false;

  @override
  void dispose() {
    pno.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.29 * width),
      body: Center(
        child: Container(
          height: 0.5 * height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Enter your OTP',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          'OTP',
                          style: TextStyle(color: Colors.grey),
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                      TextField(
                        controller: pno,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: InputDecoration(
                          errorText: ispnoerror ? 'Required field' : null,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  )),
              Container(
                width: 0.9 * width,
                color: Colors.black,
                child: MaterialButton(
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      ispnoerror = pno.text.isEmpty;
                    });
                    if (!ispnoerror)
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.routeName);
                  },
                ),
              ),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Back to Login'))
            ],
          ),
        ),
      ),
    );
  }
}
