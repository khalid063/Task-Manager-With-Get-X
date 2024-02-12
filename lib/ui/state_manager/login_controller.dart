

import 'package:get/get.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';


///--- Fresh Code ---///
class LoginController extends GetxController {

  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async{
    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.login, requestBody, isLognin: true);
    print('Response Body 999 : ${response.body}');

    _loginInProgress = false;
    update(); // update UI

    if (response.isSuccess) {
      // Login info check
      LoginModel model = LoginModel.fromJson(response.body!);     // ! -> used for forced not null
      print('First Name : ${model.data?.firstName}');
      print('First lastName : ${model.data?.lastName}');
      print('First emal : ${model.data?.email}');
      print('First mobile : ${model.data?.mobile}');
      await AuthUtility.saveUserInfo(model);

      return true;
    }else {
      return false;
    }
  }

}





///-------- Old code --------///
// class LoginController extends GetxController {
//
//   bool _loginInProgress = false;
//
//   Future<bool> login(String email, String password) async{
//     _loginInProgress = true;
//     update();
//     // if (mounted) {
//     //   setState(() {});
//     // }
//     Map<String, dynamic> requestBody = {
//       //"email": _emailTEController.text.trim(),
//       "email": email,
//       //"password": _passwordTEController.text
//       "password": password
//     };
//     final NetworkResponse response = await NetworkCaller().postRequest(Urls.login, requestBody, isLognin: true);
//     print('Response Body 999 : ${response.body}');
//
//     _loginInProgress = false;
//     update();
//     // if (mounted) {
//     //   setState(() {});
//     // }
//     // Network call is End
//     if (response.isSuccess) {
//       // Login info check
//       LoginModel model = LoginModel.fromJson(response.body!);     // ! -> used for forced not null
//       print('First Name : ${model.data?.firstName}');
//       print('First lastName : ${model.data?.lastName}');
//       print('First emal : ${model.data?.email}');
//       print('First mobile : ${model.data?.mobile}');
//       await AuthUtility.saveUserInfo(model);
//
//       return true;
//
//       // if (mounted) {
//       //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBaseScreen()), (route) => false);
//       //   return true;
//       // }
//     }else {
//
//       return false;
//
//       // if (mounted) {
//       //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect email or Password')));
//       // }
//     }
//   }
//
// }