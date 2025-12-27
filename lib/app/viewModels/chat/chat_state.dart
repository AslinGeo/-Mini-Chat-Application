import 'package:mini_chat/app/data/index.dart' show ChatMessage;

abstract class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatMessage> chatHistory;

  ChatLoaded(this.chatHistory);
}

final class ChatLoading extends ChatState {}

final class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
