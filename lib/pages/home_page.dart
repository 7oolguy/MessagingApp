import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Messages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.green,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.green,
              ),
            )
          ]),
      body:_buildUserList(),
    );
  }

  //build a list of users except for  the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return const Text('error');
        }
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }

        return ListView(
          children: 
          snapshots.data!.docs
              .map<Widget>((doc) => _builderUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _builderUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Icon(
            Icons.person,
            color: Colors.green,
            size: 35,),
          const SizedBox(width: 5),
          Text(
            data['email'],
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
        ],),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
