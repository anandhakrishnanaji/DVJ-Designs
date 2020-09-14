import 'package:dvjdesign/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import './OTPVerificationPage.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _phonefocusnode = FocusNode();
  final _emailfocusnode = FocusNode();
  final _compfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool istickederror = true;

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

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

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset('assets/images/logo.png'),
          titleSpacing: 0.29 * width),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 0.04 * height, vertical: 0.01 * height),
          child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.03 * height),
                      child: Text('Create Account',
                          style: TextStyle(fontSize: 0.035 * height)),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Enter your Name',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10)),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _phonefocusnode.requestFocus(),
                      validator: (value) =>
                          value.isEmpty ? "The field cannot be empty" : null,
                      onSaved: (newValue) => _check['name'] = newValue,
                    ),
                    SizedBox(
                      height: 0.02 * height,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your Mobile',
                            isDense: true,
                            contentPadding: EdgeInsets.all(10)),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _emailfocusnode.requestFocus(),
                        focusNode: _phonefocusnode,
                        validator: (value) {
                          if (value.isEmpty)
                            return "The field cannot be empty";
                          else if (value.length != 10)
                            return "The field must only contain 10 digits";
                          else if (!_isNumeric(value))
                            return "The field can only contain digits";
                          else
                            return null;
                        },
                        onSaved: (newValue) => _check['mobile'] = newValue),
                    SizedBox(
                      height: 0.02 * height,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your Email',
                            isDense: true,
                            contentPadding: EdgeInsets.all(10)),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _compfocusnode.requestFocus(),
                        focusNode: _emailfocusnode,
                        validator: (value) {
                          if (value.isEmpty)
                            return "The field cannot be empty";
                          else if (!EmailValidator.validate(value))
                            return "The E-mail entered is not of valid format";
                          else
                            return null;
                        },
                        onSaved: (newValue) => _check['email'] = newValue),
                    SizedBox(
                      height: 0.02 * height,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your Company Name',
                            isDense: true,
                            contentPadding: EdgeInsets.all(10)),
                        textInputAction: TextInputAction.done,
                        focusNode: _compfocusnode,
                        validator: (value) =>
                            value.isEmpty ? "This field is Required" : null,
                        onSaved: (newValue) => _check['company'] = newValue),
                    Container(
                      alignment: Alignment.topLeft,
                      //margin: EdgeInsets.all(0.01 * height),
                      height: 0.23 * height,
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
                                controlAffinity:
                                    ListTileControlAffinity.leading))
                            .toList(),
                      ),
                    ),
                    !istickederror
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Atleast one of the checkboxes must be selected',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 10,
                          ),
                    isloading
                        ? CircularProgressIndicator()
                        : Container(
                            color: Colors.black,
                            child: MaterialButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white,fontSize: 18),
                              ),
                              onPressed: () {
                                _saveform();
                                setState(() {
                                  istickederror = _checkbool[
                                          'Architect/Interior Designer'] ||
                                      _checkbool['Trader'] ||
                                      _checkbool['Individual'];
                                });
                                print(_isValid);
                                print(istickederror);
                                if (_isValid && istickederror) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  List<String> profession = [];
                                  _checkbool.keys.forEach((element) =>
                                      _checkbool[element]
                                          ? profession.add(element)
                                          : null);
                                  print(_check['mobile']);
                                  Provider.of<Auth>(context, listen: false)
                                      .register(
                                          _check['name'],
                                          _check['mobile'],
                                          _check['email'],
                                          _check['company'],
                                          profession)
                                      .then((value) {
                                    if (value)
                                      Navigator.of(context)
                                          .pushNamed(OTPVerification.routeName);
                                    setState(() {
                                      isloading = false;
                                    });
                                  }).catchError((e) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        child: Alertbox(e.toString()));
                                  });
                                }
                              },
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account ?'),
                        FlatButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(LoginPage.routeName),
                            child: Text(
                              'Login here',
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
              )),
        ),
      ),
    );
  }
}
