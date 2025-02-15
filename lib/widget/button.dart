import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonSize { small, normal, large }

enum ButtonVariant { fill, outline }

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final double? width; // Custom width (default: full width)
  final IconData? leftIcon;
  final IconData? rightIcon;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.normal,
    this.variant = ButtonVariant.fill, // Default to fill
    this.width,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBackground = colorScheme.surface;

    // Define size variations
    final Map<ButtonSize, EdgeInsets> paddingMap = {
      ButtonSize.small: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ButtonSize.normal: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ButtonSize.large: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
    };

    final Map<ButtonSize, double> fontSizeMap = {
      ButtonSize.small: 14.sp,
      ButtonSize.normal: 16.sp,
      ButtonSize.large: 18.sp,
    };

    final Map<ButtonSize, double> iconSizeMap = {
      ButtonSize.small: 16.sp,
      ButtonSize.normal: 20.sp,
      ButtonSize.large: 24.sp,
    };

    return SizedBox(
      width: width ?? double.infinity, // Default full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: variant == ButtonVariant.fill
              ? colorScheme.primary
              : scaffoldBackground,
          foregroundColor: variant == ButtonVariant.fill
              ? colorScheme.onPrimary
              : colorScheme.primary,
          side: variant == ButtonVariant.outline
              ? BorderSide(color: colorScheme.primary, width: 2.w)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: paddingMap[size],
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Only takes necessary width
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) ...[
              Icon(
                leftIcon,
                size: iconSizeMap[size],
                color: variant == ButtonVariant.fill
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
              SizedBox(width: 4.w), // Gap between left icon and text
            ],
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeMap[size],
                color: variant == ButtonVariant.fill
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
            ),
            if (rightIcon != null) ...[
              SizedBox(width: 4.w), // Smaller gap before right icon
              Icon(
                rightIcon,
                size: iconSizeMap[size],
                color: variant == ButtonVariant.fill
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
