import 'package:bloc/bloc.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repo;
  ChatBloc(this.repo) : super(ChatInitial()) {
    on<LoadChatHistory>(_loadHistory);
    on<SendMessage>(_sendMessage);
    on<ReceiveMessage>(_receiveMessage);
  }

  void _loadHistory(LoadChatHistory event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    final messages = repo.getMessages(event.userId);
    emit(ChatLoaded(messages));
  }

  Future<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final currentHistory = state is ChatLoaded
        ? (state as ChatLoaded).chatHistory
        : <ChatMessage>[];
    final msg = ChatMessage(
      id: DateTime.now().toString(),
      message: event.text,
      isSender: true,
    );

    await repo.addMessage(event.userId, msg);
    emit(ChatLoaded([...currentHistory, msg]));

    add(ReceiveMessage(event.userId));
  }

  Future<void> _receiveMessage(
    ReceiveMessage event,
    Emitter<ChatState> emit,
  ) async {
    final currentHistory = state is ChatLoaded
        ? (state as ChatLoaded).chatHistory
        : <ChatMessage>[];
    final reply = await repo.fetchRandomMessage();

    final msg = ChatMessage(
      id: DateTime.now().toString(),
      message: reply,
      isSender: false,
    );

    await repo.addMessage(event.userId, msg);
    emit(ChatLoaded([...currentHistory, msg]));
  }
}
