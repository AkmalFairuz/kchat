import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kchat/bottom_sheet_helper.dart';
import 'package:kchat/screen/home_screen.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/service/auth_service.dart';
import 'package:kchat/state/global_state.dart';
import 'package:kchat/widget/button.dart';
import 'package:kchat/widget/clickable_text.dart';
import 'package:kchat/widget/input.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  Future<void> _register() async {
    if (_usernameController.text.trim().isEmpty ||
        _fullNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmController.text.trim().isEmpty) {
      BottomSheetHelper.simplePopup(
          context: context, text: "Please fill in all fields.");
      return;
    }

    if (_passwordController.text != _confirmController.text) {
      BottomSheetHelper.simplePopup(
          context: context, text: "Passwords do not match.");
      return;
    }

    final globalState = Provider.of<GlobalState>(context, listen: false);
    BottomSheetHelper.showLoadingPopup(context: context);
    try {
      final token = await AuthService.register(
        username: _usernameController.text,
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
      );
      if (!mounted) {
        return;
      }
      BottomSheetHelper.closeLoadingPopup(context);
      globalState.setToken(token);
      final user = await AuthService.me(token);
      globalState.setLoggedUser(user);
      if (!mounted) {
        return;
      }
      ScreenHelper.replaceAll(context, (_) => const HomeScreen());
    } catch (e) {
      if (!mounted) return;
      BottomSheetHelper.closeLoadingPopup(context);
      BottomSheetHelper.simplePopup(context: context, text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Register", style: TextStyle(fontSize: 24.sp)),
                SizedBox(height: 16.h),
                Input(
                  hintText: "Username",
                  controller: _usernameController,
                ),
                SizedBox(height: 16.h),
                Input(
                  hintText: "Full Name",
                  controller: _fullNameController,
                ),
                SizedBox(height: 16.h),
                Input(
                  hintText: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                Input(
                  hintText: "Password",
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 16.h),
                Input(
                  hintText: "Confirm Password",
                  isPassword: true,
                  controller: _confirmController,
                ),
                SizedBox(height: 16.h),
                Button(
                  text: "Register",
                  onPressed: _register,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    SizedBox(width: 8.w),
                    Text("OR", style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 8.w),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 16.h),
                Button(
                  text: "Continue with Apple",
                  onPressed: () {
                    BottomSheetHelper.simplePopup(
                        context: context,
                        text:
                            "Register with Apple is not implemented yet. We are working on it.");
                  },
                  leftIcon: Icons.apple,
                  variant: ButtonVariant.outline,
                ),
                SizedBox(height: 8.h),
                Button(
                  text: "Continue with Google",
                  onPressed: () {
                    BottomSheetHelper.simplePopup(
                        context: context,
                        text:
                            "Register with Google is not implemented yet. We are working on it.");
                  },
                  leftIcon: FontAwesomeIcons.google,
                  variant: ButtonVariant.outline,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    SizedBox(width: 4.w),
                    ClickableText(
                      text: "Sign In",
                      onTap: () {
                        ScreenHelper.replace(
                            context, (_) => const LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
