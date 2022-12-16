import 'package:chat/widgets/users/user_actif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UsersActif extends StatelessWidget {
  const UsersActif({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final userDocs = snapshot.data!.docs;
          final user = FirebaseAuth.instance.currentUser!;
          return SizedBox(
            height: 85,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return UserActif(
                  userDocs[index].id,
                  userDocs[index]['username'],
                  userDocs[index]['image_url'],
                  userDocs[index]['isConnected'],
                  userDocs[index]['emai'],
                  key: ValueKey(userDocs[index].id),
                );
              },
              itemCount: userDocs.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.blueGrey,
                );
              },
            ),
          );
        });
  }
}
