import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_managet_with_get_x/ui/screens/auth/signup_screen.dart';
import 'package:task_managet_with_get_x/ui/state_manager/login_controller.dart';
import '../../../data/models/auth_utility.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/screen_background.dart';
import '../bottom_nav_base_screen.dart';
import '../email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ///======================================== GetX Controller Instance =================================================///
  final LoginController _loginController = Get.put(LoginController());

  ///======================================== All Variables ============================================================///
  // bool _loginInProgress = false;

  ///---------------------------------------- Text Editing Controller for taking username and pass ---------------------///
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  ///---------------------------------------- Login API call Function Now using GetX controller ------------------------///
  // Future<void> login() async{
  //   _loginInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   Map<String, dynamic> requestBody = {
  //     "email": _emailTEController.text.trim(),
  //     "password": _passwordTEController.text
  //   };
  //   final NetworkResponse response = await NetworkCaller().postRequest(Urls.login, requestBody, isLognin: true);
  //   print('Response Body 999 : ${response.body}');
  //   _loginInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   // Network call is End
  //   if (response.isSuccess) {
  //     // Login info check
  //     LoginModel model = LoginModel.fromJson(response.body!);     // ! -> used for forced not null
  //     print('First Name : ${model.data?.firstName}');
  //     print('First lastName : ${model.data?.lastName}');
  //     print('First emal : ${model.data?.email}');
  //     print('First mobile : ${model.data?.mobile}');
  //     await AuthUtility.saveUserInfo(model);
  //
  //     if (mounted) {
  //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBaseScreen()), (route) => false);
  //     }
  //   }else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect email or Password')));
  //     }
  //   }
  // }

  ///======================================== Scaffold Start ===========================================================///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150,),
              Text(
                'Get Started With',
                // style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500,
                //     ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 12,),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 16,),
              ///----------------------------- Login Button is Start ---------------------------------------------///   *** Login Function is "Called" Hare
              GetBuilder<LoginController>(
                //builder: (myLoginController) {
                builder: (_) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      //visible: myLoginController.loginInProgress == false,
                      visible: _loginController.loginInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          //login();
                          //myLoginController.login(_emailTEController.text.trim(), _passwordTEController.text);
                          _loginController.login(_emailTEController.text.trim(), _passwordTEController.text);
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(height: 24,),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailVerificationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Text('SignUp'),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      )
    );
  }
}




