import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kjlchat/pages/chat.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  CollectionReference userRef=FirebaseFirestore.instance.collection("Users");
  var user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userRef.where("id",isNotEqualTo: user).get(),
      builder: (context,AsyncSnapshot snapshot){
        if(snapshot.hasData){ 
          return
           ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,i){
            return userItim(quer : snapshot.data.docs[i]);
          });
        }
        return Center(child: CircularProgressIndicator(),); 
      },
    );   
  }
}

// ignore: camel_case_types
class userItim extends StatefulWidget{
  final quer;
  userItim ({this.quer});

  @override
  _userItimState createState() => _userItimState();
}

// ignore: camel_case_types
class _userItimState extends State<userItim> {
    @override
    Widget build(BuildContext context) {
      return InkWell(
        child: Container(
          color: Color(0xffd7eec4),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(3),
          height: 80,
            child: Row(children: [
              Container(
                height: 80,width: 100,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("${widget.quer["imageurl"]}"),
                ),
              ),
              Text("${widget.quer["username"]}", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,letterSpacing: 1,
                              fontFamily: "arefRuqaa"
                          ),)
          ],)
        ),
        onTap: (){
          Navigator
          .push(context, 
          MaterialPageRoute(
            // ignore: non_constant_identifier_names
            builder:(_UsersState)=>
            Chat(userdoce: "${widget.quer["id"]}")));
        },
      );  
    }
}