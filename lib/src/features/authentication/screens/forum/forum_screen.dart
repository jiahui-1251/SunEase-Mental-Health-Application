import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tForum, backgroundColor: tOrangeColor),
        body:SingleChildScrollView(
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi,", style: Theme.of(context).textTheme.titleMedium!.apply(color: tWhiteColor)),
                    Text(tForumSubTitle, style: Theme.of(context).textTheme.bodyLarge!.apply(color: tWhiteColor)),
                  ],
                  ),
              ),
            ], 
          )
        )
      ),
    );
  }
}


