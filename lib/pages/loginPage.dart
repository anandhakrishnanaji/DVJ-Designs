import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './OTPVerificationPage.dart';
import './registrationPage.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ccode, pno;
  bool ispnoerror = false;
  bool _isloading = false;

  @override
  void initState() {
    ccode = new TextEditingController();
    pno = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          centerTitle: true,),
      body: Center(
        child: Container(padding: EdgeInsets.all(30),
          height: 0.6 * height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Enter your mobile number',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                'We need to text you the OTP to authenticate your account',
                style: TextStyle(color: Colors.grey, fontSize: 18,),textAlign: TextAlign.center,
              ),
              Container(
                  width: 0.7 * width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          'Phone Number',
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
              !_isloading
                  ? Container(
                      width: 0.9 * width,
                      color: Colors.black,
                      child: MaterialButton(
                        child: Text(
                          'Send OTP',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                        onPressed: () {
                          setState(() {
                            ispnoerror = pno.text.length != 10;
                          });
                          if (!ispnoerror) {
                            setState(() {
                              _isloading = true;
                            });
                            Provider.of<Auth>(context, listen: false)
                                .otpsend(pno.text)
                                .then((value) {
                              if (value)
                                Navigator.of(context)
                                    .pushNamed(OTPVerification.routeName);
                              setState(() {
                                _isloading = false;
                              });
                            }).catchError((e) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Don\'t have an account ?'),
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Create one here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 2),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
