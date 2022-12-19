import 'package:chat/screens/private_chat_screen.dart';
import 'package:flutter/material.dart';

class UserActif extends StatelessWidget {
  const UserActif(
      this.id, this.username, this.imageUrl, this.isConnected, this.email,
      {super.key});
  final String id;
  final String imageUrl;
  final String username;
  final bool isConnected;
  final String email;

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return SizedBox(
      width: 75,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(PrivateChatScreen.routeName, arguments: {
          'id': id,
          'imageUrl': imageUrl,
          'username': username,
          'isConnected': isConnected,
          'email': email,
        }),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(imageUrl,
                      height: 65, width: 65, fit: BoxFit.cover),
                ),
                if (isConnected)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3)),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 2,
            ),
            Text(username),
          ],
        ),
      ),
    );
  }
}
