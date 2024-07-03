import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/form/privacy_policy.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/profile/widgets/profile_screen_menu_widget.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitleWidget(title: tMenu1Settings, backIcon:  LineAwesomeIcons.angle_left_solid),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize - 20),
          child: Column(
            children: [
              // MENU
              ProfileMenuWidget(title: tPrivacyPolilcy, icon: LineAwesomeIcons.user_secret_solid, onPress: () {                  
                showDialog(
                    context: context,
                    builder: (context) => PrivacyPolicyDialog(),
                  );}),
            ],
          ),
        ),
      ),
    );
  }
}
