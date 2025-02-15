import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/local_storage.dart';
import 'package:kchat/screen/home_screen.dart';
import 'package:kchat/screen/loading_screen.dart';
import 'package:kchat/screen/welcome_screen.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/service/auth_service.dart';
import 'package:kchat/state/global_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => GlobalState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var globalState = Provider.of<GlobalState>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: "Public Sans",
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness:
                    globalState.darkMode ? Brightness.dark : Brightness.light),
            textTheme: Typography.englishLike2018
                .apply(fontSizeFactor: 1.sp)
                .apply(
                    bodyColor:
                        globalState.darkMode ? Colors.white : Colors.black)
                .apply(fontFamily: "Public Sans"),
          ),
          home: child,
        );
      },
      child: LoadingScreen(exec: (context) async {
        await Future.delayed(const Duration(seconds: 1)); // simulate loading
        LocalStorage.init();

        final token = LocalStorage.getString("Token");
        if (token != null && token != "") {
          try {
            final user = await AuthService.me(token);
            if (!context.mounted) {
              return;
            }

            Provider.of<GlobalState>(context, listen: false).setToken(token);
            Provider.of<GlobalState>(context, listen: false)
                .setLoggedUser(user);

            ScreenHelper.replace(context, (_) => const HomeScreen());
            return;
          } catch (e) {
            print(e);
          }
        }
        if (!context.mounted) {
          return;
        }
        ScreenHelper.replace(context, (_) => const WelcomeScreen());
      }),
    );
  }
}
