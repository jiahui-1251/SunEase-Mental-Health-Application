import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/controllers/authentication_controller.dart';
import 'package:fyp/src/features/authentication/controllers/profile_controller.dart';
import 'package:fyp/src/features/authentication/models/user_model.dart';
import 'package:fyp/src/features/authentication/screens/login/login_screen.dart';
import 'package:fyp/src/features/authentication/screens/profile/widgets/profile_screen_menu_widget.dart';
import 'package:fyp/src/features/authentication/screens/profile/profile_settings.dart';
import 'package:fyp/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreenMenu extends StatelessWidget {
  const ProfileScreenMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final signUpController = Get.put(SignUpController());
    
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tProfile),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize - 20),
            child: FutureBuilder(
              future: profileController.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            // Profile Image
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(image: AssetImage(tProfileImage)),
                              ),
                            ),
                            // Edit button
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: tOrangeColor,
                                ),
                                child: const Icon(LineAwesomeIcons.pencil_alt_solid, size: 15.0, color: tBlackColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Username
                        Text(
                          userData.UserName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        // Email
                        Text(
                          userData.email,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => Get.to(() => UpdateProfileScreen()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tOrangeColor,
                              padding: const EdgeInsets.symmetric(vertical: 10)
                            ),
                            child: const Text(
                              tEditProfile,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // MENU
                        ProfileMenuWidget(
                          title: tMenu1Settings,
                          icon: LineAwesomeIcons.cog_solid,
                          onPress: () => Get.to(() => ProfileSettingsScreen()),
                        ),
                        ProfileMenuWidget(
                          title: tMenu2Help,
                          icon: LineAwesomeIcons.hands_helping_solid,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: tMenu3Notifications,
                          icon: LineAwesomeIcons.bell_solid,
                          onPress: () {},
                        ),
                        const Divider(),
                        ProfileMenuWidget(
                          title: tLogout,
                          icon: LineAwesomeIcons.sign_out_alt_solid,
                          onPress: () async {
                            await signUpController.signOut();
                            Get.offAll(() => const LoginScreen());
                          },
                          endIcon: false,
                        ),
                        ProfileMenuWidget(
                          title: "Delete account",
                          icon: LineAwesomeIcons.sign_out_alt_solid,
                          onPress: () async {
                            await signUpController.deleteAccount(context);
                          },
                          endIcon: false,
                          textColor: Colors.red,
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
