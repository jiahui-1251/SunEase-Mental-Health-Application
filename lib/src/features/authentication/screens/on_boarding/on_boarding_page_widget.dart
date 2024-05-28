import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: size.height * 0.4),
          Column(
            children: [
              Text(
                model.title, 
                style: Theme.of(context).textTheme.titleMedium, 
                textAlign: TextAlign.center,
              ),
              Text(
                model.subTitle, 
                style: Theme.of(context).textTheme.bodyLarge, 
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(model.counterText),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
