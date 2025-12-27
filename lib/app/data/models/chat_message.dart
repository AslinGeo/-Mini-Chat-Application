import 'package:hive/hive.dart';
part 'chat_message.g.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final bool isSender;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isSender,
  });
}
