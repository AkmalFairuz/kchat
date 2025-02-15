import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/model/user.dart';
import 'package:kchat/screen/view_user_screen.dart';
import 'package:kchat/screen_helper.dart';
import 'package:kchat/widget/input.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../model/conversation.dart';
import '../model/message.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        id: DateTime.now().toString(),
        senderId: "me", // Assuming your own avatar
        text: _messageController.text.trim(),
        timestamp: DateTime.now(),
        isMe: true,
      ));
    });

    _messageController.clear();

    // Scroll to the bottom when a new message is added
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
        onTap: () {
          ScreenHelper.push(
              context,
              (_) => ViewUserScreen(
                  user: User(
                      id: 0, username: "lorem123", fullName: "User Dummy")));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.conversation.profileImageUrl),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.conversation.username,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text("Online", style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            )
          ],
        ),
      )),
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
            child: _buildChats(context, _messages),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              SizedBox(width: 16.w),
              Expanded(
                  child: Input(
                      hintText: "Enter a message...",
                      controller: _messageController)),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: _sendMessage,
                icon: Icon(Icons.send),
              ),
              SizedBox(width: 16.w),
            ],
          ),
          SizedBox(height: 8.h),
        ]),
      ),
    );
  }

  Widget _buildChat(BuildContext context, Message message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.senderId,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8.w),
                    Timeago(
                        builder: (_, v) => Text(
                              v,
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),
                        date: message.timestamp)
                  ],
                ),
                SizedBox(height: 3.h),
                Text(message.text), // Remove Expanded here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChats(BuildContext context, List<Message> messages) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildChat(context, message);
      },
    );
  }
}
