import 'package:chat/widgets/chat/messages.dart';
import 'package:chat/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat/private_messages.dart';
import '../widgets/chat/private_new_message.dart';
import '../widgets/profile/profile.dart';

class PrivateChatScreen extends StatefulWidget {
  const PrivateChatScreen({super.key});
  static final routeName = "private-chat-screen";
  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen((messgae) {
      print(messgae);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final id = args['id'];
    final imageUrl = args['imageUrl'];
    final nameuser = args['username'];
    final email = args['email'];
    final isConnected = args['isConnected'];

    print(id);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(imageUrl!,
                    height: 40, width: 40, fit: BoxFit.cover),
              ),
              if (true)
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
          title: Text(nameuser!),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                      .pushNamed(Profile.routeName, arguments: {
                    'id': id,
                    'imageUrl': imageUrl,
                    'username': nameuser,
                    'email': email
                  }),
              icon: Icon(Icons.info)),
          DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (itmeIdentifier) async {
                if (itmeIdentifier == 'logout') {
                  final user = FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update({"isConnected": false});
                  await FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: PrivateMessages(id!)),
            PrivateNewMessage(id),
          ],
        ),
      ),
    );
  }
}
