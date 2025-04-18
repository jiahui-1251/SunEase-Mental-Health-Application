import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/image_strings.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/meditation/meditation_audio_widget.dart';
import 'package:fyp/src/features/authentication/screens/widgets/horizontal_image_text.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// Define a class to hold icon and title data
class MeditationCategory {
  final IconData icon;
  final String title;

  MeditationCategory({required this.icon, required this.title});
}

// Create a list of CategoryItem instances
final List<MeditationCategory> categories = [
  MeditationCategory(icon: Iconsax.smileys, title: 'Beg'),
  MeditationCategory(icon: Iconsax.user_tick, title: 'High Beg'),
];

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  String selectedCategory = 'Trending';
  List<MeditationAudioWidget> meditationWidgets = [];

  @override
  void initState() {
    super.initState();
    // Initialize with all videos for 'Trending'
    meditationWidgets = _buildMeditationWidgets('Trending');
  }

  List<MeditationAudioWidget> _buildMeditationWidgets(String category) {
    if (category == 'Beg') {
      return [
        MeditationAudioWidget(
          audioTitle: "Daily Meditation",
          audioSubtitle: "5 mins | beg",
          backgroundImages: tMeditationImage1,
          videoUrl: "https://www.youtube.com/watch?v=inpok4MKVLM",
        ),
        MeditationAudioWidget(
          audioTitle: "Stress Relief",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage2,
          videoUrl: "https://youtu.be/z6X5oEIg6Ak?si=KktmB0-v7WilvAh3",
        ),
        MeditationAudioWidget(
          audioTitle: "Sleep",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage3,
          videoUrl: "https://youtu.be/aEqlQvczMJQ?si=5Gqi0zTg191O1XZw",
        ),
        MeditationAudioWidget(
          audioTitle: "Anxiety",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage4,
          videoUrl: "https://youtu.be/O-6f5wQXSu8?si=eDWbBaK3wvxosFxu",
        ),
        MeditationAudioWidget(
          audioTitle: "Healing",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage5,
          videoUrl: "https://youtu.be/2FGR-OspxsU?si=hcDC1Yl9p6yYOdxq",
        ),
      ];
    } else if (category == 'High Beg') {
      return [
        MeditationAudioWidget(
          audioTitle: "Self Love",
          audioSubtitle: "15 mins | high beg",
          backgroundImages: tMeditationImage6,
          videoUrl: "https://youtu.be/itZMM5gCboo?si=jD_VqEGsJKhaXnoZ",
        ),
      ];
    } else {
      return [
        MeditationAudioWidget(
          audioTitle: "Daily Meditation",
          audioSubtitle: "5 mins | beg",
          backgroundImages: tMeditationImage1,
          videoUrl: "https://www.youtube.com/watch?v=inpok4MKVLM",
        ),
        MeditationAudioWidget(
          audioTitle: "Stress Relief",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage2,
          videoUrl: "https://youtu.be/z6X5oEIg6Ak?si=KktmB0-v7WilvAh3",
        ),
        MeditationAudioWidget(
          audioTitle: "Sleep",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage3,
          videoUrl: "https://youtu.be/aEqlQvczMJQ?si=5Gqi0zTg191O1XZw",
        ),
        MeditationAudioWidget(
          audioTitle: "Anxiety",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage4,
          videoUrl: "https://youtu.be/O-6f5wQXSu8?si=eDWbBaK3wvxosFxu",
        ),
        MeditationAudioWidget(
          audioTitle: "Healing",
          audioSubtitle: "10 mins | beg",
          backgroundImages: tMeditationImage5,
          videoUrl: "https://youtu.be/2FGR-OspxsU?si=hcDC1Yl9p6yYOdxq",
        ),
        MeditationAudioWidget(
          audioTitle: "Self Love",
          audioSubtitle: "15 mins | high beg",
          backgroundImages: tMeditationImage6,
          videoUrl: "https://youtu.be/itZMM5gCboo?si=jD_VqEGsJKhaXnoZ",
        ),
      ];
    }
  }

  void _onCategoryTap(String category) {
    setState(() {
      selectedCategory = category == 'Beg' ? 'Beginner Meditation' : 'High Beginner Meditation';
      meditationWidgets = _buildMeditationWidgets(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'Trending'; // Reset the selected category when back button is pressed
                meditationWidgets = _buildMeditationWidgets('Trending');
              });
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left_solid),
          ),
          title: Text(
            tMeditation,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          backgroundColor: tOrangeColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  tCategory,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return THorizontalImageText(
                      icon: category.icon,
                      title: category.title,
                      textColor: tBlackColor,
                      backgroundColor: tOrangeColor,
                      onTap: () => _onCategoryTap(category.title),
                    );
                  },
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  selectedCategory,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              ...meditationWidgets,
            ],
          ),
        ),
      ),
    );
  }
}
