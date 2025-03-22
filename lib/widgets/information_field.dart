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
    return Container(
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
        child: Flexible(
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
      ),
    );
  }
}
