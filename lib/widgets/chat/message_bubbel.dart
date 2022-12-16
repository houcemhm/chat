import 'package:flutter/material.dart';

class MeassageBubbel extends StatelessWidget {
  const MeassageBubbel(this.message, this.isMe, this.username, this.imageUrl,
      {super.key});

  final String message;
  final bool isMe;
  final String username;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe

                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12)),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        color: isMe
                            ? const Color.fromARGB(255, 67, 27, 27)
                            : Colors.black),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: -10,
            left: isMe ? null : 120,
            right: !isMe ? null : 120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ))
      ],
    );
  }
}
