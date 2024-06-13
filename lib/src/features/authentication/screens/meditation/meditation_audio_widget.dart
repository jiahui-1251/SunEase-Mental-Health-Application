import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';

class MeditationAudioWidget extends StatelessWidget {
  const MeditationAudioWidget({
    super.key,
    required this.audioTitle,
    required this.audioSubtitle,
    required this.backgroundImages,
  });

  final String audioTitle;
  final String audioSubtitle;
  final String backgroundImages;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Added vertical padding for top and bottom margins
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: tGreyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(backgroundImages),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton(
                  onSelected: (value) {
                    // Handle the remove action
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove'),
                    ),
                  ],
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Second Row
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Container(),
            ),

            // Third Row
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          audioTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          audioSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // Handle play/pause action
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Icon(Icons.play_arrow, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
