import 'package:flutter/material.dart';

class ScreenHelper {
  static void push(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  static void replaceAll(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: builder),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void replace(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
  }
}
