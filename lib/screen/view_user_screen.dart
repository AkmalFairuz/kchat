import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kchat/model/user.dart';

class ViewUserScreen extends StatelessWidget {
  const ViewUserScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Info'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.h),
              Center(
                child: CircleAvatar(
                    radius: 60.r,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/women/3.jpg")),
              ),
              SizedBox(height: 16.h),
              Text(user.fullName,
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Text("@${user.username}", style: TextStyle(fontSize: 12.sp)),
              SizedBox(height: 16.h),
              ListTile(
                leading: Icon(FontAwesomeIcons.comment),
                title: Text("Message"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.person_remove),
                title: Text("Remove from friends"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.block),
                title: Text("Block this user"),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
