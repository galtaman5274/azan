import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final double size;
  const MainButton(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.text,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;
  const SettingsButton(
      this.color, this.text, this.value, this.setting, this.callback, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(setting, value),
      color: color,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
