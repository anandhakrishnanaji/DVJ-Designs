import 'package:flutter/material.dart';

import './homePage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _phonefocusnode = FocusNode();
  final _emailfocusnode = FocusNode();
  final _compfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool _isValid = false;

  Map<String, bool> _checkbool = {
    'Architect/Interior Designer': false,
    'Trader': false,
    'Individual': false
  };

  Map<String, dynamic> _check = {
    'name': null,
    'mobile': null,
    'email': null,
    'company': null,
  };

  void _saveform() {
    _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    print(_check);
  }

  @override
  void dispose() {
    _phonefocusnode.dispose();
    _emailfocusnode.dispose();
    _compfocusnode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.194 * width),
      body: Padding(
        padding: EdgeInsets.all(0.041 * height),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.0273 * height),
                    child: Text('Sign In',
                        style: TextStyle(fontSize: 0.041 * height)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your Name',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _phonefocusnode.requestFocus(),
                    validator: (value) =>
                        value.isEmpty ? "This field is Required" : null,
                    onSaved: (newValue) => _check['name'] = newValue,
                  ),
                  SizedBox(
                    height: 0.0273 * height,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Mobile',
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _emailfocusnode.requestFocus(),
                      focusNode: _phonefocusnode,
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['phone'] = newValue),
                  SizedBox(
                    height: 0.0273 * height,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _compfocusnode.requestFocus(),
                      focusNode: _emailfocusnode,
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['email'] = newValue),
                  SizedBox(
                    height: 0.0273 * height,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Company Name',
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: _compfocusnode,
                      onFieldSubmitted: (_) {
                        _saveform();
                        if (_isValid)
                          Navigator.of(context)
                              .pushReplacementNamed(HomePage.routeName);
                      },
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['company'] = newValue),
                  Container(
                    margin: EdgeInsets.all(0.0273 * height),
                    height: 0.232 * height,
                    child: Column(
                      children: _checkbool.keys
                          .map((String key) => CheckboxListTile(
                              title: Text(key),
                              value: _checkbool[key],
                              onChanged: (bool value) {
                                setState(() {
                                  _checkbool[key] = value;
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
                        _saveform();
                        if (_isValid)
                          Navigator.of(context)
                              .pushReplacementNamed(HomePage.routeName);
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
