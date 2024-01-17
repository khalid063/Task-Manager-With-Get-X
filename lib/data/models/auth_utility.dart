import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_model.dart';

class AuthUtility {
  AuthUtility._();  /// Single Tone Object Creator, we have to use "static" key word in front of our method or function
  static LoginModel userInfo = LoginModel();


  static Future<void> saveUserInfo(LoginModel model) async{
    SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
    //_shairedPrefs.setDouble('user-data', model.toJson().toString() as double);
    //await _shairedPrefs.setString('user-data', model.toJson().toString());
    await _shairedPrefs.setString('user-data', jsonEncode(model.toJson()));
    userInfo = model;
  }

  static Future<void> updateUserInfo(UserData data) async{
    SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
    userInfo.data = data;
    await _shairedPrefs.setString('user-data', jsonEncode(userInfo.toJson()));
  }

  static Future<LoginModel> getUserInfo() async{
    SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
    String value  = _shairedPrefs.getString('user-data')!;
    //LoginModel model = LoginModel.fromJson(jsonDecode(value));
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> clearUserInfo() async{
    SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
    await _shairedPrefs.clear();
  }

  /// old code checkIfUserLoggedIn
  // static Future<bool> checkIfUserLoggedIn() async{
  //   SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
  //   return await _shairedPrefs.containsKey('user-data');
  // }
  /// new code of checkIfUserLoggedIn
  static Future<bool> checkIfUserLoggedIn() async{
    SharedPreferences _shairedPrefs = await SharedPreferences.getInstance();
    //return await _shairedPrefs.containsKey('user-data');
    bool isLogin = _shairedPrefs.containsKey('user-data');
    if (isLogin) {
      userInfo = await getUserInfo();
    }
    return isLogin;
  }


}