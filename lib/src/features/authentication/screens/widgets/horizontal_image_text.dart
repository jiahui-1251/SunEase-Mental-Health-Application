import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';

class THorizontalImageText extends StatelessWidget {
  const THorizontalImageText({
    super.key, 
    required this.icon, 
    required this.title, 
    this.textColor = Colors.white, 
    this.backgroundColor = tOrangeColor, 
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          width: 175, // Adjust width as needed
          height: 300, // Adjust height as needed
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 40),
              const SizedBox(height: 8),
              Text(
                title, 
                style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
