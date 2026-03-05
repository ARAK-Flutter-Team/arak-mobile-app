import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/chat_user.dart';

class UsersListScreen extends StatelessWidget {

  final String currentUserId;
  final List<ChatUser> users;

  const UsersListScreen({
    super.key,
    required this.currentUserId,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:  const AppMainAppBar(
        title: "Messages",
        showBackButton: true,
      ),

      body: ListView.builder(
        itemCount: users.length,

        itemBuilder: (context, index) {

          final user = users[index];

          return ListTile(

            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
            ),

            title: Text(user.name),

            subtitle: Text(
              user.role == "parent" ? "Parent" : "Teacher",
            ),

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

        },
      ),
    );
  }
}