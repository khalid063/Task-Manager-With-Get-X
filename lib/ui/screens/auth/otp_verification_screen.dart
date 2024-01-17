import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_managet_with_get_x/ui/screens/auth/reset_password_screen.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/screen_background.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  ///======================================== All Variables ==========================================================================================///
  final TextEditingController _otpTEController = TextEditingController();
  bool _otpVerificationInProgress = false;

  ///---------------------------------------- OTP API call Function --------------------------------------------------------------------------------///
  Future<void> verifyOTP() async {
    _otpVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.otpVerify(widget.email, _otpTEController.text));
    _otpVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email, otp: _otpTEController.text,),),);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Verification has been failed!'),),);
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64,),
                  Text(
                    'Otp Verification Screen',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    'A 6 digits pin will sent to your email address',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ///=========================================== *** OTP plugin use start ============================///
                  PinCodeTextField(
                    controller: _otpTEController,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      //activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.red,
                      activeColor: Colors.white,
                      selectedColor: Colors.greenAccent,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    //backgroundColor: Colors.white,
                    enableActiveFill: true,
                    cursorColor: Colors.greenAccent,
                    enablePinAutofill: true,
                    //errorAnimationController: errorController,
                    //controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, appContext: context,
                  ),
                  ///=========================================== *** OTP plugin use start ============================///
                  const SizedBox(height: 12,),
                  Visibility(
                    visible: _otpVerificationInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen()), (route) => false);
                          verifyOTP();
                        },
                        child: Text('Verify'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
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
      ),
    );
  }
}
