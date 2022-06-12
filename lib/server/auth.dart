import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServer {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Create(String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore
          .collection("Users")
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        "id": firebaseAuth.currentUser!.uid,
        "username": name,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: non_constant_identifier_names
  Future SignIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    }
  }

  // ignore: non_constant_identifier_names
  SignOut() async {
    return firebaseAuth.signOut();
  }

  // ignore: non_constant_identifier_names
  ResetPass(String email, BuildContext context) async {
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.of(context).pushReplacementNamed("login");
    });
  }
}
