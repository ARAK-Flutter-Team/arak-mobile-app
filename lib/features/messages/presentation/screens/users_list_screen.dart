import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/chat_user.dart';
import '../widgets/user_tile.dart';

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
      appBar: const AppMainAppBar(
        title: "Messages",
        showBackButton: true,
      ),

      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserTile(
            user: user,
            currentUserId: currentUserId,
          );
        },
      ),
    );
  }
}