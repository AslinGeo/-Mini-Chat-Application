import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  final http.Client client;

  ChatRepository({http.Client? client}) : client = client ?? http.Client();
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
    final response = await client.get(
      Uri.parse('https://dummyjson.com/quotes/random'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['quote'];
    } else {
      throw Exception('Failed to fetch quote');
    }
  }
}
