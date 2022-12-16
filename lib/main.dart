import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/private_chat_screen.dart';
import 'package:chat/screens/tabs_screen.dart';
import 'package:chat/screens/users_screen.dart';
import 'package:chat/widgets/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final user;
  // This widget is the root of your application.
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final user = FirebaseAuth.instance.currentUser;
    if (state == AppLifecycleState.resumed) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"isConnected": true});
      print('aaaa');
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"isConnected": false});
      print('aaaa');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.orange[60],
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.orange[400]),
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabsScreen();
            }
            return AuthScreen();
          }),
      routes: {
        TabsScreen.routeName: (ctx) => TabsScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        PrivateChatScreen.routeName: (ctx) =>  PrivateChatScreen(),
        UsersScreen.routeName: (ctx) =>  UsersScreen(),
        HomeScreen.routeName: (ctx) =>  HomeScreen(),
        Profile.routeName: (ctx) => Profile(),
      },
    );
  }
}
