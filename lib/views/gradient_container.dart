import 'package:flutter/material.dart';

import '/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.black,
              AppColors.secondaryBlack,
              AppColors.darkBlue,
              AppColors.accentBlue,
              AppColors.lightBlue,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 36),
          child: ListView(children: children),
        ),
      ),
    );
  }
}
