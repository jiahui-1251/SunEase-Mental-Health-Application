import 'package:flutter/material.dart';
import 'package:fyp/src/common_widgets/custom_shapes/container/circular_container.dart';
import 'package:fyp/src/common_widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:fyp/src/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: tOrangeColor,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(backgroundColor: tWhiteColor.withOpacity(0.1))
                ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(backgroundColor: tWhiteColor.withOpacity(0.1))
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
