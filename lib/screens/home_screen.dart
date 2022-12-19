import 'package:flutter/material.dart';
import 'package:chat/widgets/users/users_actif.dart';

import '../widgets/chats/chats.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [UsersActif(), Expanded(child: Chats())],
      ),
    );
  }
}
