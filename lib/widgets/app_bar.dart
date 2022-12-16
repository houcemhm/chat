import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        DropdownButton(
            icon: const Icon(Icons.more_vert),
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
                await FirebaseAuth.instance.signOut();
              }
            })
      ],
    );
  }
}
