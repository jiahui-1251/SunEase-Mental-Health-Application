import 'package:flutter/material.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:fyp/src/features/authentication/controllers/authentication_controller.dart'; 

class PageTitleWidget extends StatelessWidget implements PreferredSizeWidget {
  const PageTitleWidget({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>(); 

    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(LineAwesomeIcons.angle_left_solid),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(LineAwesomeIcons.sign_out_alt_solid),
          onPressed: () async {
            await signUpController.signOut();
            Get.offAll(() => const LoginScreen());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
