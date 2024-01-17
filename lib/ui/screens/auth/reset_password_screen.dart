import 'package:flutter/material.dart';
import '../../widgets/screen_background.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64,),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6,),
                Text(
                  'Minumum length password 8 character with Latter and number combination',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                    },
                    child: Text('Confirm'),
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
    );
  }
}
