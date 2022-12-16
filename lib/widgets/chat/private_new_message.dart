import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PrivateNewMessage extends StatefulWidget {
  const PrivateNewMessage(this.id, {super.key});
  final String id;
  @override
  State<PrivateNewMessage> createState() => _PrivateNewMessageState();
}

class _PrivateNewMessageState extends State<PrivateNewMessage> {
  final _controller = new TextEditingController();
  String _enteredMessage = "";
  void _sendMessage() async {
    // FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;
    final sender = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    print(sender['username']);
    final receptor = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get();

    await FirebaseFirestore.instance.collection('private-chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'senderId': user.uid,
      'receptorname': receptor['username'],
      'receptorId': widget.id,
      'sendername': sender['username'],
      'senderImage': sender['image_url'],
      'receptorImage': receptor['image_url']
    });
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ssssssssss");
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(labelText: 'Send a Message...'),
          onChanged: (value) {
            setState(() {
              _enteredMessage = value;
            });
          },
          controller: _controller,
        )),
        IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send))
      ]),
    );
  }
}
