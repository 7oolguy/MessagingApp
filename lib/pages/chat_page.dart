import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person, size: 30, color: Color.fromARGB(255, 123, 237, 127),),
            Text(
              widget.receiverUserEmail,
              style: TextStyle(
                color: Colors.green,
              ),
              
              ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          _buildMessageInput(),

          SizedBox(height: 20,),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return Text("Error${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }

        return Container(
          color: Colors.grey,
          child: ListView(
            children: snapshot.data!.docs
            .map((document) => _buildMessageItem(document))
            .toList(),
          ),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document){
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      
      var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
      var color = (data['senderID'] == _firebaseAuth.currentUser!.uid) ? Colors.green : Color.fromARGB(255, 35, 35, 35);
      var colorSec = (data['senderID'] == _firebaseAuth.currentUser!.uid) ? Color.fromARGB(255, 35, 35, 35) : Colors.green;
      
      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: Text(
                    data['senderEmail'],
                    style: TextStyle(
                        fontSize: 15,
                        color: colorSec, 
                    ),
                    ),
                ),
              ),
              const SizedBox(height: 0,),
              ChatBubble(message: data['message']),
          ]),
      );
      }

  //build message input
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type here...",
              obscureText: false,
            ),
          ),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward, size: 50,)),
        ],
      ),
    );
  }
}