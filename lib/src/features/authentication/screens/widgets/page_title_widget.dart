import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PageTitleWidget extends StatelessWidget implements PreferredSizeWidget{
  const PageTitleWidget({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
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
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
