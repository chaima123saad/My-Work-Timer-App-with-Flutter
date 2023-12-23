import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton(
      {required this.color,
      required this.text,
      required this.onPressed,
      this.size = 150});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final double size;
  final String setting;
  final CallbackSetting callback;

  const SettingsButton(
      {required this.color,
      required this.text,
      required this.value,
      required this.size,
      required this.setting,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
      minWidth: this.size,
    );
  }
}
