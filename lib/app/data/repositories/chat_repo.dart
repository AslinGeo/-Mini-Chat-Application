import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  final Box<UserChat> box = Hive.box<UserChat>('chatBox');

  List<ChatMessage> getMessages(String userId) {
    final userChat = box.get(userId);
    return userChat?.messages ?? [];
  }

  // Add a message for a user
  Future<void> addMessage(String userId, ChatMessage message) async {
    final userChat = box.get(userId);

    if (userChat != null) {
      userChat.messages.add(message);
      await userChat.save();
    } else {
      await box.put(userId, UserChat(userId: userId, messages: [message]));
    }
  }

  // Clear chat for a user
  Future<void> clearChat(String userId) async {
    await box.delete(userId);
  }

  Future<String> fetchRandomMessage() async {
    final response = await http.get(Uri.parse('http://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['content'];
    } else {
      throw Exception('Failed to fetch quote');
    }
  }
}
