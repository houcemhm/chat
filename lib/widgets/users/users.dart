import 'package:chat/screens/users_screen.dart';
import 'package:chat/widgets/users/user_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('username', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final userDocs = snapshot.data!.docs;
          final user = FirebaseAuth.instance.currentUser;
          return ListView.separated(
            itemBuilder: (ctx, index) {
              if (userDocs[index].id != user!.uid) {
                return UserItem(
                  userDocs[index].id,
                  userDocs[index]['username'],
                  userDocs[index]['image_url'],
                  userDocs[index]['isConnected'],
                  userDocs[index]['emai'],
                  key: ValueKey(userDocs[index].id),
                );
              }
            },
            itemCount: userDocs.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.blueGrey,
              );
            },
          );
        });
  }
}
