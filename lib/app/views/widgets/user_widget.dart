import 'package:flutter/material.dart';
import 'package:mini_chat/app/core/index.dart';
import 'package:mini_chat/app/data/index.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: -4),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.lightBlue,
            child: Text(user.initial, style: TextStyle(color: AppColors.white)),
          ),
          Positioned(
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
          ),
        ],
      ),
      title: Text(user.name),
      subtitle: Text(AppStrings.active),
    );
  }
}
