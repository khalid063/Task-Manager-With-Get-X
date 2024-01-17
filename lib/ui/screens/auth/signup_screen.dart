import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  /// Form Validation
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  /// work 1. controller add for all TextFormField
  final TextEditingController _emailTEController = TextEditingController();			///*** Add all controllers
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _productTotalPriceTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  ///======================================== SignUp API Call ==========================================================================================///
  Future<void> userSignUp() async {
    _signUpInProgress = true;       /// For loder
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, <String, dynamic>{
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": ""
    });
    ///================= for loder =================///
    _signUpInProgress = false;
    if (mounted) {
      setState(() {});
    }
    ///================= for loder =================///
    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Success!'),),);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed!'),),);
      }
    }
  }

  ///======================================== Scaffold Part ==========================================================================================///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150,),
                Text(
                  'Join With Us',
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
                  validator: ( String? value){
                    if (value?.trim().isEmpty ?? true){
                      return 'Enter Your Email Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _firstNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  validator: ( String? value){
                    if (value?.trim().isEmpty ?? true){
                      return 'Enter Your First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _lastNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: ( String? value){
                    if (value?.trim().isEmpty ?? true){
                      return 'Enter Your Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _mobileTEController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  validator: ( String? value){
                    if ((value?.trim().isEmpty ?? true) || value!.length  < 11){
                      return 'Enter Your valid Mobile Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: ( String? value){
                    if ((value?.trim().isEmpty ?? true) || value!.length  <= 5){
                      return 'Enter Your password more then 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _signUpInProgress == false,
                    replacement: const Center(child:  CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {

                        // if ( !_formState.currentState!.validate()){		///*** use this code for start validation (start) task manager code (new)
                        //     return;
                        // }

                        if ( _formState.currentState!.validate()){		///*** use this code for start validation (start)
                          userSignUp();
                        }
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Sign in'),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        ),
      )
    );
  }
}




