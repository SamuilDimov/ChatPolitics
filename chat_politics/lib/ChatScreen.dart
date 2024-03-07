import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();

void _sendMessage() {
  if (_textController.text.isNotEmpty) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String senderEmail = currentUser.email ?? "Unknown"; // Default to "Unknown" if email is null
      setState(() {
        _messages.add("${_textController.text}, $senderEmail"); // Remove .text from senderEmail
        _textController.clear();
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final String senderEmail;

  Message(this.text, this.senderEmail);

  @override
  String toString() {
    return '$senderEmail: $text';
  }
}