import 'package:flutter/material.dart';
import 'package:mini_chat/app/core/constants/app_strings.dart';
import 'package:mini_chat/app/data/index.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 50, child: Text(user.initial)),
      title: Text(user.name),
      subtitle: Text(AppStrings.active),
    );
  }
}
