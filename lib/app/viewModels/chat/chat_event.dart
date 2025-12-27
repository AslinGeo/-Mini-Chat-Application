abstract class ChatEvent {
  const ChatEvent();
}

class LoadChatHistory extends ChatEvent {
  final String userId;

  LoadChatHistory(this.userId);
}

class SendMessage extends ChatEvent {
  final String text;
  final String userId;

  SendMessage(this.text, this.userId);
}

class ReceiveMessage extends ChatEvent {
  final String userId;

  ReceiveMessage(this.userId);
}
