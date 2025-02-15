import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/screen/register_screen.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/widget/button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Button(
                      text: "Sign Up",
                      onPressed: () {
                        ScreenHelper.push(
                            context, (_) => const RegisterScreen());
                      },
                    ),
                    SizedBox(height: 8.h),
                    Button(
                      text: "Login",
                      onPressed: () {
                        ScreenHelper.push(context, (_) => const LoginScreen());
                      },
                      variant: ButtonVariant.outline,
                    ),
                  ],
                ))));
  }
}
