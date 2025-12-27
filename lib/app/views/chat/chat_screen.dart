import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/app/core/constants/app_colors.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';
import 'package:mini_chat/app/views/index.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  const ChatScreen({super.key, required this.userModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(LoadChatHistory(widget.userModel.id));
  }

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Column(
          children: [
            Expanded(child: chatList(widget.userModel.name)),
            messageInputBar(),
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.lightGray),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Expanded(
              child: UserWidget(
                user: widget.userModel,
                backgroundColor: AppColors.lightBlue,
                isOnline: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageInputBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
        child: Row(
          children: [
            // Text field
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Send button
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    context.read<ChatBloc>().add(
                      SendMessage(controller.text, widget.userModel.id),
                    );
                    controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatList(String name) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChatLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.chatHistory.length,
            itemBuilder: (_, index) {
              final msg = state.chatHistory[index];
              return ChatBubble(msg: msg, userName: name);
            },
          );
        }
        if (state is ChatError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
