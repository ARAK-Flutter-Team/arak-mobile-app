import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/chat_user.dart';
import 'avatar_widget.dart';

class UserTile extends StatelessWidget {
  final ChatUser user;
  final String currentUserId;

  const UserTile({
    super.key,
    required this.user,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarWidget(url: user.avatarUrl),
      title: Text(user.name),
      subtitle: Text(user.role == "parent" ? "Parent" : "Teacher"),
      onTap: () {
        context.push(
          '/chat',
          extra: {
            "currentUserId": currentUserId,
            "otherUserId": user.id,
            "name": user.name,
            "role": user.role,
            "avatarUrl": user.avatarUrl,
          },
        );
      },
    );
  }
}