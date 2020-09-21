import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _session = null;
  Map _userdetails = {
    'name': null,
    'mobile': null,
    'email': null,
    'company': null
  };
  List _sliderlist = [];
  get session => _session;

  get name => _userdetails['name'];
  get mobile => _userdetails['mobile'];
  get email => _userdetails['email'];
  get company => _userdetails['company'];

  get userdetails => _userdetails;

  Future<bool> login(String otp) async {
    print(otp);
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/login?mobile=${_userdetails['mobile']}&pass=$otp';
    print(url);
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body) as Map;
      if (jresponse['status'] == 'failed')
        throw (jresponse['message']);
      else {
        print(jresponse);
        print(jresponse['data']['session']);
        _sliderlist = jresponse['data']['slider'];
        _session = jresponse['data']['session'];
        _userdetails['name'] = jresponse['data']['userinfo']['name'];
        _userdetails['mobile'] = jresponse['data']['userinfo']['email'];
        _userdetails['email'] = jresponse['data']['userinfo']['email'];
        _userdetails['company'] = jresponse['data']['userinfo']['company'];

        await _saveToken();

        return true;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> _saveToken() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString('session', _session);
    shr.setString('name', _userdetails['name']);
    shr.setString('mobile', _userdetails['mobile']);
    shr.setString('email', _userdetails['email']);
    shr.setString('company', _userdetails['company']);
  }

  Future<bool> register(String name, String mobile, String email,
      String company, List<String> profession) async {
    _userdetails['mobile'] = mobile;
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/registration?name=$name&mobile=$mobile&email=$email&company=$company&profession=$profession';
    print(url);
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body);
      if (jresponse['status'] == 'failed')
        throw (jresponse['message']);
      else
        return true;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<bool> otpsend(final String mobile) async {
    print(mobile);
    _userdetails['mobile'] = mobile;
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/get_login_otp?mobile=$mobile';
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body);
      print(jresponse);
      if (jresponse['status'] == 'failed')
        throw (jresponse['message']);
      else
        return true;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<bool> isloggedin() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    print(shr.containsKey('session'));
    print(shr.containsKey('username'));
    if (shr.containsKey('session') && shr.containsKey('username')) {
      _session = shr.getString('session');
      final response = await http
          .get('https://dvj-design.com/api_dvj/Serv_v1/home?session=$session');
      final jresponse = json.decode(response.body);
      if (jresponse['status'] == 'failed') {
        shr.clear();
        return false;
      } else {
        _userdetails['name'] = shr.getString('name');
        _userdetails['mobile'] = shr.getString('mobile');
        _userdetails['email'] = shr.getString('email');
        _userdetails['company'] = shr.getString('company');

        return true;
      }
    } else
      return false;
  }

  Future<void> logout() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.clear();
    _session = null;
  }

  Future<List> obtainSliderItems() async {
    print('slider');
    print(_sliderlist == []);
    try {
      if (_sliderlist.length == 0) {
        print('hi bro\n\n');
        final url =
            'https://dvj-design.com/api_dvj/Serv_v1/home?session=$session';
        final response = await http.get(url);
        final jresponse = json.decode(response.body) as Map;
        print(jresponse);
        if (jresponse['status'] == 'failed') throw (jresponse['message']);
        _sliderlist = jresponse['data']['slider'];
        print(_sliderlist);
        return _sliderlist;
      } else
        return _sliderlist;
    } catch (e) {
      throw (e.toString());
    }
  }
}
