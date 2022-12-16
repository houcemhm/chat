import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubbel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
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
              return MeassageBubbel(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == user!.uid,
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                key: ValueKey(chatDocs[index].id),
              );
            },
            itemCount: chatDocs.length,
          );
        });
  }
}
