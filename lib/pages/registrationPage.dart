import 'package:flutter/material.dart';

import './homePage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Map<String, bool> _check = {
    'Architect/Interior Designer': false,
    'Trader': false,
    'Individual': false
  };
  bool _nameerr = false,
      _phoneerr = false,
      _emailerr = false,
      _companyerr = false;

  TextEditingController _name, _phone, _email, _company;

  @override
  void initState() {
    super.initState();
    _name = new TextEditingController();
    _phone = new TextEditingController();
    _email = new TextEditingController();
    _company = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Sign In', style: TextStyle(fontSize: 30)),
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                  labelText: 'Enter your Name',
                  errorText: _nameerr ? 'Required Field' : null),
            ),
            TextField(
              controller: _phone,
              decoration: InputDecoration(
                  errorText: _phoneerr ? 'Required Field' : null,
                  labelText: 'Enter your Mobile'),
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  errorText: _emailerr ? 'Required Field' : null,
                  labelText: 'Enter your Email id'),
            ),
            TextField(
              controller: _company,
              decoration: InputDecoration(
                  errorText: _companyerr ? 'Required Field' : null,
                  labelText: 'Enter your Company Name'),
            ),
            Container(
              height: 170,
              child: Column(
                children: _check.keys
                    .map((String key) => CheckboxListTile(
                        title: Text(key),
                        value: _check[key],
                        onChanged: (bool value) {
                          setState(() {
                            _check[key] = value;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading))
                    .toList(),
              ),
            ),
            Container(
              color: Colors.black,
              child: MaterialButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _nameerr = _name.text.isEmpty;
                      _phoneerr = _phone.text.isEmpty;
                      _emailerr = _email.text.isEmpty;
                      _companyerr = _company.text.isEmpty;
                    });
                    if (!_nameerr && !_phoneerr && !_emailerr && !_companyerr)
                      Navigator.of(context).pushNamed(HomePage.routeName);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
