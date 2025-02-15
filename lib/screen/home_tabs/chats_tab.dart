import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kchat/bottom_sheet_helper.dart';
import 'package:kchat/model/conversation.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/widget/input.dart';

import '../../widget/button.dart';
import '../../widget/chat_entry.dart';
import '../chat_screen.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab>
    with AutomaticKeepAliveClientMixin {
  List<Map<String, String>> users = []; // Store user data

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=100"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data["results"];

      setState(() {
        setState(() {
          users = results.map<Map<String, String>>((user) {
            return {
              "name": "${user["name"]["first"]} ${user["name"]["last"]}",
              "profileImageUrl": user["picture"]["medium"],
            };
          }).toList();
        });
      });
    } else {
      print("Failed to load users");
    }
  }

  void _addChatModal() {
    BottomSheetHelper.show(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        SizedBox(height: 16.h),
        Text("Start New Chat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp)),
        SizedBox(height: 16.h),
        Input(
          hintText: "Enter username to start chat",
          controller: TextEditingController(),
          variant: InputVariant.filled,
        ),
        SizedBox(height: 16.h),
        Button(
          text: "Start Chat",
          onPressed: () {
            ScreenHelper.replace(
                context,
                (_) => ChatScreen(
                    conversation: Conversation(
                        id: "1",
                        userId: "1",
                        username: "Sebastian",
                        profileImageUrl:
                            "https://randomuser.me/api/portraits/men/1.jpg")));
          },
        ),
        SizedBox(height: 16.h),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Row(
              children: [
                Text(
                  "Chats",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
                ),
                Spacer(),
                IconButton(
                    onPressed: _addChatModal,
                    icon: Icon(Icons.add),
                    iconSize: 26.sp)
              ],
            )),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Input(
              hintText: "Search chats",
              variant: InputVariant.filled,
              controller: TextEditingController(),
              leftIcon: Icons.search),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: users.isEmpty
              ? Center(child: CircularProgressIndicator()) // Loading Indicator
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ChatEntry(
                      title: user["name"]!,
                      onHold: () {
                        print("Held on ${user["name"]}");
                      },
                      lastMessage: "Hello, how are you?",
                      time: "12:3${index} PM",
                      imageUrl: user["profileImageUrl"]!,
                      unreadCount: index % 3,
                      isOnline: index % 2 == 0,
                      onTap: () {
                        ScreenHelper.push(
                          context,
                          (_) => ChatScreen(
                              conversation: Conversation(
                                  id: "",
                                  userId: "",
                                  username: user["name"]!,
                                  profileImageUrl: user["profileImageUrl"]!)),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
