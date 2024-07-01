import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: "Add Mood", backgroundColor: tOrangeColor),
      ),
    );
  }
}