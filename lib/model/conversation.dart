import 'message.dart';

class Conversation {
  final String id;
  final String userId;
  final String username;
  final String profileImageUrl;
  final Message? lastMessage;

  Conversation({
    required this.id,
    required this.userId,
    required this.username,
    required this.profileImageUrl,
    this.lastMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      profileImageUrl: json['profileImageUrl'],
      lastMessage: json['lastMessage'] != null
          ? Message.fromJson(json['lastMessage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'lastMessage': lastMessage?.toJson(),
    };
  }
}
