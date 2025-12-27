import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_chat/app/core/index.dart';
import 'package:mini_chat/app/data/index.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  final Color backgroundColor;
  final bool isOnline;
  final String? lastMessage;
  final String? createdAt;
  const UserWidget({
    super.key,
    required this.user,
    required this.backgroundColor,
    required this.isOnline,
    this.lastMessage,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Nav.push(context, RoutePaths.chat, extra: user);
      },
      visualDensity: VisualDensity(horizontal: -4),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: backgroundColor,
            child: Text(user.initial, style: TextStyle(color: AppColors.white)),
          ),
          isOnline
              ? Positioned(
                  bottom: 5,
                  right: 25,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2, color: AppColors.white),
                    ),
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      title: Text(user.name),
      subtitle: Text(lastMessage ?? AppStrings.active, maxLines: 1),
      trailing: createdAt != null
          ? Text(DateFormat.jm().format(DateTime.parse(createdAt!)))
          : null,
    );
  }
}
