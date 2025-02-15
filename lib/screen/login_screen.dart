import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kchat/bottom_sheet_helper.dart';
import 'package:kchat/screen/register_screen.dart';
import 'package:kchat/service/auth_service.dart';
import 'package:kchat/widget/button.dart';
import 'package:kchat/widget/clickable_text.dart';
import 'package:kchat/widget/input.dart';
import 'package:provider/provider.dart';

import '../screen_helper.dart';
import '../state/global_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      BottomSheetHelper.simplePopup(
          context: context, text: "Please fill in all fields.");
      return;
    }

    final globalState = Provider.of<GlobalState>(context, listen: false);
    try {
      BottomSheetHelper.showLoadingPopup(context: context);
      final token = await AuthService.login(
          username: _usernameController.text,
          password: _passwordController.text);
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
              Text("Login", style: TextStyle(fontSize: 24.sp)),
              SizedBox(height: 16.h),
              Input(hintText: "Username", controller: _usernameController),
              SizedBox(height: 16.h),
              Input(
                  hintText: "Password",
                  isPassword: true,
                  controller: _passwordController),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: ClickableText(
                  text: "Forgot Password?",
                  onTap: () {
                    BottomSheetHelper.simplePopup(
                        context: context,
                        text:
                            "Forgot Password is not implemented yet. We are working on it.");
                  },
                ),
              ),
              SizedBox(height: 8.h),
              Button(text: "Login", onPressed: _login),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            "Login with Apple is not implemented yet. We are working on it.");
                  },
                  leftIcon: Icons.apple,
                  variant: ButtonVariant.outline),
              SizedBox(height: 8.h),
              Button(
                  text: "Continue with Google",
                  onPressed: () {
                    BottomSheetHelper.simplePopup(
                        context: context,
                        text:
                            "Login with Google is not implemented yet. We are working on it.");
                  },
                  leftIcon: FontAwesomeIcons.google,
                  variant: ButtonVariant.outline),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  SizedBox(width: 4.w),
                  ClickableText(
                    text: "Sign Up",
                    onTap: () {
                      ScreenHelper.replace(
                          context, (_) => const RegisterScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
