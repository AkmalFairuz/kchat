import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kchat/screen/home_tabs/chats_tab.dart';
import 'package:kchat/screen/home_tabs/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const ChatsTab(),
    Container(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _tabs,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidComments, size: 24.sp),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.compass, size: 24.sp),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gear, size: 24.sp),
            label: 'Utility',
          ),
        ],
      ),
    );
  }
}
