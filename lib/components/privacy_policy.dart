import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By creating an account, you are agreeing to our \n",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = (){
                //Open dialogue of privacy policy on tap
                showDialog(
                    context: context,
                    builder: (context) => PrivacyPolicyDialog(),
                  );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Privacy Policy"),
      content: FutureBuilder(
        future: rootBundle.loadString('assets/privacy_policy.md'),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SingleChildScrollView(
              child: Text(snapshot.data!),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}

void checkMarkdownFile() async {
  try {
    // Load the contents of the Markdown file
    String markdownContent = await rootBundle.loadString('assets/privacy_policy.md');

    // If the file was successfully loaded, print its contents
    print(markdownContent);
  } catch (e) {
    // If an error occurs, print the error message
    print('Error loading Markdown file: $e');
  }
}
