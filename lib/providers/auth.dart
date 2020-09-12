import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _username = null;
  String _session = null;
  String _otp = null;
  get session => _session;

  get username => _username;

  Future<bool> login(String otp) async {
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/login?mobile=$username&pass=$_otp';
    try {
      final response = await http.get(url);
      final jresponse = json.decode(response.body) as Map;
      if (jresponse['status'] == 'failed')
        throw (jresponse['message']);
      else {
        _session = jresponse['session'];
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
    shr.setString('username', _username);
  }

  Future<bool> register(String name, String mobile, String email,
      String company, List<String> profession) async {
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/registration?name=$name&mobile=$mobile&email=$email&company=$company&profession=$profession';
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
    final url =
        'https://dvj-design.com/api_dvj/Serv_v1/get_login_otp?mobile=$mobile';
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

  Future<bool> isloggedin() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    if (shr.containsKey('session') && shr.containsKey('username')) {
      _session = shr.getString('session');
      _username = shr.getString('username');

      return true;
    } else
      return false;
  }

  Future<void> logout() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.clear();
    _session = null;
    _username = null;
  }
}
