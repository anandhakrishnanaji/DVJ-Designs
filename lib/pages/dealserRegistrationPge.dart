import 'package:flutter/material.dart';

class DealerRegistration extends StatefulWidget {
  @override
  _DealerRegistrationState createState() => _DealerRegistrationState();
}

class _DealerRegistrationState extends State<DealerRegistration> {
  final _phonefocusnode = FocusNode();
  final _emailfocusnode = FocusNode();
  final _addressfocusnode = FocusNode();
  final _cprofilefocusnode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool _isValid = false;

  Map<String, dynamic> _check = {
    'name': null,
    'address': null,
    'cpname': null,
    'mobile': null,
    'email': null,
    'cprofile': null,
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
    _cprofilefocusnode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 70,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('Design Registration', style: TextStyle(fontSize: 30)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your Company Name',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _addressfocusnode.requestFocus(),
                    validator: (value) =>
                        value.isEmpty ? "This field is Required" : null,
                    onSaved: (newValue) => _check['name'] = newValue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Company Address',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _addressfocusnode,
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['address'] = newValue),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Contact Person Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _phonefocusnode.requestFocus(),
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['cpname'] = newValue),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Mobile',
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      focusNode: _phonefocusnode,
                      onFieldSubmitted: (_) => _emailfocusnode.requestFocus(),
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['mobile'] = newValue),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Contact Email Id',
                      ),
                      focusNode: _emailfocusnode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          _cprofilefocusnode.requestFocus(),
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['email'] = newValue),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Company Profile',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _cprofilefocusnode,
                      validator: (value) =>
                          value.isEmpty ? "This field is Required" : null,
                      onSaved: (newValue) => _check['cprofile'] = newValue),
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.black,
                    child: MaterialButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _saveform();
                        //if (_isValid)
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
