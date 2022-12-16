import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubbel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrivateMessages extends StatelessWidget {
  const PrivateMessages(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('private-chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = snapshot.data!.docs;
          final user = FirebaseAuth.instance.currentUser;
          
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              if ((chatDocs[index]['senderId'] == user!.uid &&
                      chatDocs[index]['receptorId'] == id) ||
                  (chatDocs[index]['receptorId'] == user.uid &&
                      chatDocs[index]['senderId'] == id)) {
                return MeassageBubbel(
                  chatDocs[index]['text'],
                  chatDocs[index]['senderId'] == user.uid,
                  chatDocs[index]['sendername'],
                  chatDocs[index]['senderImage'],
                  key: ValueKey(chatDocs[index].id),
                );
              }
            },
            itemCount: chatDocs.length,
          );
        });
  }
}
