import 'package:flutter/material.dart';
import 'package:fyp/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/features/authentication/controllers/authentication_controllers.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_mail.dart';
import 'package:fyp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:fyp/src/features/authentication/screens/forum/forum_screen.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:fyp/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:fyp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:fyp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:fyp/src/features/authentication/screens/widgets/navigation_menu.dart';
import 'package:fyp/src/features/forum_post/controllers/post_controller.dart';
import 'package:fyp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:fyp/src/repository/forum_repository/forum_repository.dart';
import 'package:fyp/src/repository/user_repository/user_repository.dart';
import 'package:fyp/src/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( //initialize Firebase App before using firebase service
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(ForumPostRepository());
  Get.put(SignUpController());
  Get.put(PostController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    // return const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: AuthPage()
    //   );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: LoginScreen(),
    );
  }
}
