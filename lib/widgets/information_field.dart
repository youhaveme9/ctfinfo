import 'package:ctfinfo/style/pallet.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InformationField extends StatelessWidget {
  final String value;

  const InformationField({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      txtTitle: value,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      textOverflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -22,
          left: 24,
          child: Container(
            padding: EdgeInsets.fromLTRB(2, 18, 2, 4),
            decoration: BoxDecoration(
              color: Pallet.blackColour,
            ),
            child: CustomText(
              txtTitle: "Information",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
