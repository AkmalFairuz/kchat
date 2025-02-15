import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const ClickableText({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: style ??
              TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}
