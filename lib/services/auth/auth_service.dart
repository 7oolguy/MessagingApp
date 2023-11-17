import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService extends ChangeNotifier {
  //instance auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instace firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
          
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid' : userCredential.user!.uid,
            'email' : email,
          });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

          //after creating user, create new document for the user in the users collections
          _fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid' : userCredential.user!.uid,
            'email' : email,
          });

          return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
