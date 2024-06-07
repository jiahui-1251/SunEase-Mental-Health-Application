import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key, 
    required this.icon, 
    required this.title, 
    required this.textColor, 
    required this.backgroundColor, 
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
        padding: const EdgeInsets.only(right: spaceBtwItems),
        child: Column(
          children: [
            // Circular icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(tDefaultSize - 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Icon(icon, color: textColor), // Use the icon parameter here
              ),
            ),
        
            const SizedBox(height: spaceBtwItems / 2),
        
            SizedBox(
              width: 55,
              child: Text(
                title, 
                style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
