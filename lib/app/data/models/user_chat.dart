import 'package:hive/hive.dart';
import 'package:mini_chat/app/data/index.dart';

part 'user_chat.g.dart';

@HiveType(typeId: 2)
class UserChat extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  List<ChatMessage> messages;

  UserChat({required this.userId, required this.messages});
}
