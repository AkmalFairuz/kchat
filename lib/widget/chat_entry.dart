import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatEntry extends StatelessWidget {
  final String title;
  final String lastMessage;
  final String time;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback? onHold; // Optional long-press callback
  final int unreadCount;
  final bool isOnline; // NEW: Online status flag

  const ChatEntry({
    super.key,
    required this.title,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    required this.onTap,
    this.onHold,
    this.unreadCount = 0,
    this.isOnline = false, // Default to offline
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onHold, // Triggers on hold if provided
        splashColor: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Profile Picture with Status Indicator
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 26.r,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        Positioned(
                          bottom: 2.r,
                          right: 2.r,
                          child: Container(
                            width: 14.r,
                            height: 14.r,
                            decoration: BoxDecoration(
                              color: isOnline ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),

                    // Chat Details (Username & Message)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            lastMessage,
                            style: TextStyle(
                              color: unreadCount > 0
                                  ? null // Make text bold if unread
                                  : Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: unreadCount > 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Timestamp + Unread Count Badge
              Column(
                mainAxisSize: MainAxisSize.min, // Keeps this section compact
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  if (unreadCount > 0)
                    Container(
                      margin: EdgeInsets.only(top: 6.h), // Space from timestamp
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        unreadCount > 99 ? "99+" : unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
