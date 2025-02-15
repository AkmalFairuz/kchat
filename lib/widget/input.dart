import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/state/global_state.dart';

enum InputSize { small, normal, large }

enum InputVariant { filled, outlined, underlined }

class Input extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final InputSize size;
  final InputVariant variant;
  final bool isPassword;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const Input({
    super.key,
    required this.hintText,
    required this.controller,
    this.size = InputSize.normal,
    this.variant = InputVariant.outlined,
    this.isPassword = false,
    this.leftIcon,
    this.rightIcon,
    this.errorText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize _obscureText to the value of isPassword
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Define size variations for text and padding
    final Map<InputSize, double> fontSizeMap = {
      InputSize.small: 14.sp,
      InputSize.normal: 16.sp,
      InputSize.large: 18.sp,
    };

    final Map<InputSize, EdgeInsets> paddingMap = {
      InputSize.small: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      InputSize.normal: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      InputSize.large: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    };

    // Define a separate mapping for icon sizes
    final Map<InputSize, double> iconSizeMap = {
      InputSize.small: 18.sp,
      InputSize.normal: 22.sp,
      InputSize.large: 26.sp,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: TextStyle(fontSize: fontSizeMap[widget.size]!),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: fontSizeMap[widget.size]!,
              color: Colors.grey,
            ),
            contentPadding: paddingMap[widget.size],
            filled: widget.variant == InputVariant.filled,
            fillColor: widget.variant == InputVariant.filled
                ? (GlobalState.isDarkMode(context)
                    ? Colors.grey[800]
                    : Colors.grey[200])
                : null,
            border: _getBorder(widget.variant, colorScheme),
            enabledBorder: _getBorder(widget.variant, colorScheme),
            focusedBorder:
                _getBorder(widget.variant, colorScheme, isFocused: true),
            errorText: widget.errorText,
            prefixIcon: widget.leftIcon != null
                ? Icon(widget.leftIcon, size: iconSizeMap[widget.size]!)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: iconSizeMap[widget.size]!,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.rightIcon != null
                    ? Icon(widget.rightIcon, size: iconSizeMap[widget.size]!)
                    : null,
          ),
        ),
      ],
    );
  }

  InputBorder _getBorder(InputVariant variant, ColorScheme colorScheme,
      {bool isFocused = false}) {
    switch (variant) {
      case InputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: isFocused ? colorScheme.primary : Colors.grey[400]!,
            width: 1.5.w,
          ),
        );
      case InputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: isFocused ? colorScheme.primary : Colors.grey[400]!,
            width: 1.5.w,
          ),
        );
      case InputVariant.filled: // Add rounded border for filled variant
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Ensure rounded corners
          borderSide: BorderSide.none, // Remove the border outline
        );
    }
  }
}
