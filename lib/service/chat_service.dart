import 'package:sqflite/sqflite.dart';

class ChatService {
  late final Database _db;

  void init() async {
    _db = await openDatabase('chat.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE users (id TEXT PRIMARY KEY, name TEXT)',
      );
      await db.execute(
          'CREATE TABLE messages (id TEXT PRIMARY KEY, conversationId INTEGER, senderId TEXT, content TEXT, timestamp INTEGER, isRead INTEGER)');
      await db.execute(
          'CREATE TABLE conversations (id TEXT PRIMARY KEY, name TEXT, toUserId TEXT)');
      await db.execute(
          'CREATE INDEX messages_conversationId ON messages(conversationId)');
    });
  }
}
