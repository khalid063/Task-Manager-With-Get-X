import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import 'auth/otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  ///======================================== All Variables ====================================================================================///
  bool _emailVerificationInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

  ///---------------------------------------- Email Verification API Call ----------------------------------------------------------------------///
  Future<void> sendOTPToEmail() async {
    _emailVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.sendOtpToEmail(_emailTEController.text.trim()));
    _emailVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationScreen(email: _emailTEController.text.trim()),),);

      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Emai Verification has been failed!'),),);
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
                    'Your Email Address',
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
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Visibility(
                    visible: _emailVerificationInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationScreen()));
                          sendOTPToEmail();
                        },
                        child: Icon(Icons.arrow_circle_right_outlined),
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
      ),
    );
  }
}
