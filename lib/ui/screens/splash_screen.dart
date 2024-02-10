import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../data/models/auth_utility.dart';
import '../utils/assets_utils.dart';
import '../widgets/screen_background.dart';
import 'auth/login_screen.dart';
import 'bottom_nav_base_screen.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToLogin();
  }

  /// this is the best way, this one kind of "Completer"
  Future<void> navigateToLogin() async {


    Future.delayed(Duration(seconds: 5)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();
      if (mounted) {
        /// use Get X for "Navigation" work
        Get.offAll(
          isLoggedIn ? const BottomNavBaseScreen() : const LoginScreen(),
        );

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => isLoggedIn
        //             ? const BottomNavBaseScreen()
        //             : const LoginScreen()),
        //
        //     /// Tarnary operator for login or home screen
        //     (route) => false);

      }
    });

  }

  /// anather way for Delay method
  // Future<void> navigateToLogin() async {
  //   await Future.delayed(Duration(seconds: 5));
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
  // }


  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: Center(
          child: SvgPicture.asset(AssetsUtils.logoSVG, width: 80, fit: BoxFit.scaleDown,),
        )
    );
  }
}
