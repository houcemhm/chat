import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/private_chat_screen.dart';
import '../../screens/users_screen.dart';

class UserItem extends StatelessWidget {
  const UserItem(
      this.userID, this.username, this.imageUrl, this.isConnected, this.email,
      {super.key});
  final String username;
  final String imageUrl;
  final bool isConnected;
  final String userID;
  final String email;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(PrivateChatScreen.routeName,
          arguments: {
            'id': userID,
            'imageUrl': imageUrl,
            'username': username,
            'email': email
          }),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: Text(username),
      trailing: isConnected
          ? Icon(
              Icons.circle,
              color: Color.fromARGB(255, 41, 168, 45),
              size: 10,
            )
          : null,
    );
  }
}
