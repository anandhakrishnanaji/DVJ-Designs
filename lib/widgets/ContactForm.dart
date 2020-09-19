import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../providers/auth.dart';
import '../providers/productProvider.dart';
import '../widgets/alertBox.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  bool _isloading = false;
  final _phonefocusnode = FocusNode();
  final _emailfocusnode = FocusNode();
  final _messagefocusnode = FocusNode();
  final _form = GlobalKey<FormState>();

  Map<String, dynamic> _check = {
    'name': null,
    'mobile': null,
    'email': null,
    'message': null,
  };

  void _saveform() {
    _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    print(_check);
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    _phonefocusnode.dispose();
    _emailfocusnode.dispose();
    _messagefocusnode.dispose();
    super.dispose();
  }

  bool _isValid = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(0.048 * width),
      child: Form(
          key: _form,
          child: Column(children: [
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
                onFieldSubmitted: (_) => _messagefocusnode.requestFocus(),
                focusNode: _emailfocusnode,
                validator: (value) {
                  if (value.isEmpty)
                    return null;
                  else if (!EmailValidator.validate(value))
                    return "The E-mail entered is not of valid format";
                  else
                    return null;
                },
                onSaved: (newValue) => _check['email'] = newValue),
            SizedBox(
              height: 0.0273 * height,
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your Message',
                ),
                focusNode: _messagefocusnode,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (value) => null,
                onSaved: (newValue) => _check['message'] = newValue),
            _isloading
                ? CircularProgressIndicator()
                : Container(
                    margin: EdgeInsets.all(0.027 * height),
                    color: Colors.black,
                    child: MaterialButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _saveform();
                        if (_isValid) {
                          setState(() => _isloading = true);
                          final String session =
                              Provider.of<Auth>(context, listen: false).session;
                          Provider.of<ProductProvider>(context, listen: false)
                              .sendEnquiry(
                                  _check['name'], _check['mobile'], session,
                                  email: _check['email'],
                                  msg: _check['message'])
                              .then((value) {
                            setState(() => _isloading = false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Enquiry sent successfully')));
                          }).catchError((e) {
                            setState(() => _isloading = false);
                            showDialog(
                                context: context,
                                child: Alertbox(e.toString()));
                          });
                        }
                      },
                    ),
                  )
          ])),
    );
  }
}
