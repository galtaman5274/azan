import 'package:flutter/material.dart';

class TextWithMark extends StatelessWidget {
  const TextWithMark({
    Key? key,
    required this.title,
    required this.isRequired,
    this.textStyle,
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Text(
            title,
            style: textStyle ??
                const TextStyle(
                    fontFamily: 'Intro',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
          ),
          isRequired
              ? const Text(
                  ' *',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
