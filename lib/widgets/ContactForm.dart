import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
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
          child: Column(children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your Name',
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => _phonefocusnode.requestFocus(),
          validator: (value) => value.isEmpty ? "This field is Required" : null,
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
            onFieldSubmitted: (_) => _messagefocusnode.requestFocus(),
            focusNode: _emailfocusnode,
            validator: (value) =>
                value.isEmpty ? "This field is Required" : null,
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
            validator: (value) =>
                value.isEmpty ? "This field is Required" : null,
            onSaved: (newValue) => _check['company'] = newValue),
        Container(
          margin: EdgeInsets.all(0.027 * height),
          color: Colors.black,
          child: MaterialButton(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _saveform,
          ),
        )
      ])),
    );
  }
}
