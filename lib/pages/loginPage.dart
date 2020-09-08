import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ccode, pno;
  bool ispnoerror = false;

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
      body: Center(
        child: Container(
          height: 0.3 * height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Enter your mobile number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'We need to text you the OTP to authenticate your account',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Container(
                  width: 270,
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
              Container(
                width: 0.9 * width,
                color: Colors.blue,
                child: MaterialButton(
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      ispnoerror = pno.text.isEmpty;
                    });
                    //if (!ispnoerror) Navigator.of(context).pushNamed(HomePage.routeName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
