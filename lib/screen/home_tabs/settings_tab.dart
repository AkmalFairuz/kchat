import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/state/global_state.dart';
import 'package:provider/provider.dart';

import '../account_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var globalState = Provider.of<GlobalState>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Text(
            "Utility",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
          ),
        ),
        SizedBox(height: 4.h),
        SingleChildScrollView(
          child: Column(children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: globalState.darkMode,
                onChanged: (value) {
                  globalState.toggleDarkMode();
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Account"),
              onTap: () {
                ScreenHelper.push(context, (_) => const AccountScreen());
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text("Privacy & Policy"),
              leading: Icon(Icons.privacy_tip),
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Terms & Conditions"),
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.info),
              onTap: () {},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text("Clear Cache"),
              onTap: () {},
              leading: Icon(Icons.delete),
            ),
          ]),
        )
      ],
    );
  }
}
