import 'package:ctfinfo/constants/image_constants.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String title;
  const CustomHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 10),
        Image.asset(ImageConstants.lines),
        const SizedBox(height: 10),
      ],
    );
  }
}
