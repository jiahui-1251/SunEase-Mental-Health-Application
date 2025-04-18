import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tResources, backgroundColor: tOrangeColor, backIcon: LineAwesomeIcons.smile),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        tXMUMCounselling,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _launchURL("https://forms.office.com/r/thC285mjta");
                          },
                          child: Text(
                            "Link to registration form",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: tOrangeColor, 
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tOnlineResources,

                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "1. The Malaysian Mental Health \nAssociation (MMHA)", 
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "Phone: +603 2780 6803\nWebsite: www.mmha.org.my", 
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.left,
                          ),

                          SizedBox(height: tFormHeight - 20),

                          Text(
                            "2. My Psycholog", 
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "Phone: +6011-3344 5270\nWebsite: www.mypsychology.my/", 
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.left,
                          ),

                          SizedBox(height: tFormHeight - 20),
                          
                          Text(
                            "3. Be Frienders", 
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "Phone: +603-76272929 \nWebsite: www.befrienders.org.my/", 
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: tFormHeight - 20),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tCounsellingCentres,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "1. MentCouch Psychology Centre", 
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10), 
                          Text(
                            "Address: Suite 1-02, 1st Floor, Menara Atlan, 161B, Jalan Ampang, 50450 Kuala Lumpur", 
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.left,
                          ),

                          SizedBox(height: tFormHeight - 20),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
