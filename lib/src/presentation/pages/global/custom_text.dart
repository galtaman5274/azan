import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

enum TextStyles {
  displaySmall,
  displayMedium,
  lableSmall,
  labelMedium,
  titleMedium,
  titleLarge
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, required this.textStyle});
  final String text;
  final TextStyles textStyle;
  TextStyle? pickStyle(BuildContext context) {
    switch (textStyle) {
      case TextStyles.displaySmall:
        return Theme.of(context).textTheme.displaySmall;
      case TextStyles.displayMedium:
        return Theme.of(context).textTheme.displayMedium;
      case TextStyles.lableSmall:
        return Theme.of(context).textTheme.labelSmall;
      case TextStyles.labelMedium:
        return Theme.of(context).textTheme.labelMedium;
      case TextStyles.titleLarge:
        return Theme.of(context).textTheme.titleLarge;
      case TextStyles.titleMedium:
        return Theme.of(context).textTheme.titleMedium;
      default:
        return Theme.of(context).textTheme.labelMedium;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: pickStyle(context),
    );
  }
}
