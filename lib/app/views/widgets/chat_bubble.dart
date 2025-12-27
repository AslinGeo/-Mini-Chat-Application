import 'package:flutter/material.dart';
import 'package:mini_chat/app/core/constants/app_colors.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage msg;
  final String userName;
  const ChatBubble({super.key, required this.msg,required this.userName});

  @override
  Widget build(BuildContext context) {
    final isSender = msg.isSender;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSender) avatar('B', isSender),

          Column(
            crossAxisAlignment: isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 260),
                decoration: BoxDecoration(
                  color: isSender ? AppColors.lightBlue : AppColors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  msg.message,
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  DateFormat.jm().format(DateTime.parse(msg.id)),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),

          if (isSender) avatar('Y', isSender),
        ],
      ),
    );
  }

  Widget avatar(String initial, bool isSender) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: isSender ? AppColors.lightBlue : AppColors.green,
      child: Text(
        initial,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
