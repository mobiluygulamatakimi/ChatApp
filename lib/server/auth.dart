
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServer{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore= FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Create (String name ,String email , String password)async{
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await firestore
          .collection("Users").doc(firebaseAuth.currentUser!.uid).set({
            "id" : firebaseAuth.currentUser!.uid,
            "username":name,
            'email': email,
            "storyCount" : 0,
            'imageurl' : "https://firebasestorage.googleapis.com/v0/b/kjlchatapp-44698.appspot.com/o/KjlLogo.jpg?alt=media&token=2d5fb271-f1dd-43e5-bdc6-a98597caf326"
          });   
      return userCredential.user ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
    }

  }

  // ignore: non_constant_identifier_names
  SignIn (String email,String password)async{
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
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
  SignOut ()async{
    return firebaseAuth.signOut();
  }


  // ignore: non_constant_identifier_names
  ResetPass (String email,BuildContext context)async{
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value){
      Navigator.of(context).pushReplacementNamed("login");
    });
  }
}