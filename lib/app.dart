import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_managet_with_get_x/data/models/summary_count_model.dart';
import 'package:task_managet_with_get_x/ui/screens/splash_screen.dart';
import 'package:task_managet_with_get_x/ui/state_manager/login_controller.dart';
import 'package:task_managet_with_get_x/ui/state_manager/summary_count_controller.dart';


class TaskManagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App Practice for CRUD',
      theme: ThemeData(
          brightness: Brightness.light,
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //backgroundColor: Colors.green,
            elevation: 3,
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          )
        )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      initialBinding:  ControllerBinding(),       //*** for Bind with GetX controller
      home: const SplashScren(),
    );
  }
}

//*** for Bind with GetX controller
class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCountController>(SummaryCountController());                   ///*** NO 2 Work
  }

}

// login controller "Find" code
// LoginController loginController = Get.find<LoginController>();


//============================ Full Code =======================================//

// class _LoginScreenState extends State<LoginScreen> {
//
//   LoginController loginController = Get.find<LoginController>();
//
//   ///======================================== GetX Controller Instance =================================================///
//   final LoginController _loginController = Get.put(LoginController());
//
//   ///======================================== All Variables ============================================================///
//   // bool _loginInProgress = false;  // Now use 'login_controller.dart'
//
//   ///---------------------------------------- Text Editing Controller for taking username and pass ---------------------///
//   final TextEditingController _emailTEController = TextEditingController();
//   final TextEditingController _passwordTEController = TextEditingController();



