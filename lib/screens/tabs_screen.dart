import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/users_screen.dart';

import '../widgets/helpers/dropdown_widget.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  static final routeName = '/home';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectPagePageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': UsersScreen(),
        'title': 'Active Now',
      },
      {
        'page': HomeScreen(),
        'title': 'Home',
      },
      {
        'page': ChatScreen(),
        'title': 'Rooms',
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPagePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPagePageIndex]['title'] as String),
        actions: [
          DropDownWidget(),
        ],
      ),
      body: _pages[_selectPagePageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(Icons.people),
            label: 'Active Now',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(Icons.chat),
            label: 'my room',
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _selectPagePageIndex,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
