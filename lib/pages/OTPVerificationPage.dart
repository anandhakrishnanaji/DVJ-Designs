import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homePage.dart';
import '../widgets/alertBox.dart';
import '../providers/auth.dart';

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

  bool _isloading = false;

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
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 50),
        height: 0.5 * height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Enter your OTP',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'OTP was sent to ${Provider.of<Auth>(context, listen: false).mobile}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
                width: 0.41 * width,
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
                        errorText: ispnoerror ? 'Invalid OTP' : null,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(),
                      ),
                    )
                  ],
                )),
            !_isloading
                ? Container(
                    width: 0.9 * width,
                    color: Colors.black,
                    child: MaterialButton(
                      child: Text(
                        'Verify',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          ispnoerror = pno.text.length != 6;
                        });
                        if (!ispnoerror) {
                          setState(() {
                            _isloading = true;
                          });
                          Provider.of<Auth>(context, listen: false)
                              .login(pno.text)
                              .then((value) => value
                                  ? Navigator.of(context)
                                      .pushReplacementNamed(HomePage.routeName)
                                  : null)
                              .catchError((e) {
                            setState(() {
                              _isloading = false;
                            });
                            showDialog(
                                context: context,
                                child: Alertbox(e.toString()));
                          });
                        }
                      },
                    ),
                  )
                : CircularProgressIndicator(),
            FlatButton(
                onPressed: () => Provider.of<Auth>(context, listen: false)
                    .otpsend(Provider.of<Auth>(context, listen: false).mobile),
                child: Text(
                  'Send Again',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
