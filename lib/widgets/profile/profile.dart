import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const routeName = 'profile';
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final id = args['id'];
    final imageUrl = args['imageUrl'];
    final nameuser = args['username'];
    final email = args['email'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.orange,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(imageUrl!),
            ),
            Text(
              nameuser!,
              style: TextStyle(
                fontFamily: '36',
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'friend',
              style: TextStyle(
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.cyan[700],
                ),
                title: Text(
                  email!,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
