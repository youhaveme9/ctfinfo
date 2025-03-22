import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? txtTitle;
  final TextStyle? style;
  final TextAlign? align;
  final Alignment? btnTextAlignment;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final void Function()? onPressed;
  final bool? softWrap;

  const CustomText({
    super.key,
    this.txtTitle,
    this.style,
    this.align = TextAlign.start,
    this.maxLine,
    this.textOverflow,
    this.onPressed,
    this.btnTextAlignment,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget textWidget = Text(
      txtTitle ?? "",
      style: style,
      softWrap: softWrap,
      textAlign: align,
      maxLines: maxLine,
      overflow: style?.overflow ?? TextOverflow.clip,
    );
    return onPressed == null
        ? textWidget
        : TextButton(
            onPressed: onPressed,
            child: Align(
              alignment: btnTextAlignment ?? Alignment.center,
              child: textWidget,
            ),
          );
  }
}
