import 'package:shared_preferences/shared_preferences.dart';

class Local {
  static SharedPreferences? _prefs;
  static Future initDatabase() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<dynamic> getValue() async {
    return _prefs!.getString('uid');
  }

  static Future<bool> isLoggedIn() async {
    return _prefs!.containsKey('uid');
  }

  static Future<dynamic> setValue({required String? value}) async {
    if (value != null)
      return _prefs!.setString('uid', value);
    else
      return _prefs!.remove('uid');
  }

//set user name
  static Future<dynamic> setUserName({required String value}) async {
    _prefs!.setString('userName', value);
    return true;
  }

//get user name
  static Future<dynamic> getUserName() async {
    return _prefs!.getString('userName');
  }

  // set and get the designation
  static Future<dynamic> setDesignation({required String value}) async {
    _prefs!.setString('designation', value);
    return true;
  }

  static Future<dynamic> getDesignation() async {
    return _prefs!.getString('designation') ?? 'Occupational Therapist';
  }
  // check whether user is logged in or not
}
