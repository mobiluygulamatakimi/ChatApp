import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  final userdoce;
  Chat({this.userdoce});
  @override
  _ChatState createState() => _ChatState(userdoc: userdoce);
}

class _ChatState extends State<Chat> {
  var userdoc;
  _ChatState({this.userdoc});

  bool isSender = false;
  final TextEditingController messageCon=TextEditingController();

  CollectionReference chatref = FirebaseFirestore.instance.collection("Chats");

  var user = FirebaseAuth.instance.currentUser!.uid;
  
  setMessage(String message)async{
    int time= DateTime.now().millisecondsSinceEpoch;
    
    await chatref.add({
      "sender" : user,
      "receiver" : userdoc,
      "message" : message,
      "chatId" : "$user$userdoc",
      "time" : time,
      "timeh" : "${DateTime.now().hour+3}:${DateTime.now().minute}"
    });
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference userRef=FirebaseFirestore.instance.collection("Users");

    return Scaffold(
      backgroundColor: Color(0xffd7eec4),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:FutureBuilder(
            future: userRef.where("id",isEqualTo: userdoc).get(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.jpg"),
                    ),
                    SizedBox(width: 8,),
                    Text("${snapshot.data.docs[0]["username"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,letterSpacing: 1,
                          fontFamily: "arefRuqaa"
                      ),),
                  ],
                );}
              return Center(child: CircularProgressIndicator(),);
            }

        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(           
            child: StreamBuilder<QuerySnapshot>(
              stream: chatref
              .where("chatId",whereIn: ["$user$userdoc","$userdoc$user"]).orderBy('time',descending: true).snapshots(),
              builder: (context,AsyncSnapshot snapshot){
                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
                if(snapshot.hasData){
                  return  ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    reverse: true,
                    itemCount:snapshot.data.docs.length,
                    itemBuilder: (context,i){
                      if(snapshot.data.docs[i]["sender"]=="$user"){
                        isSender=true;
                      }else{
                        isSender=false;
                      }
                    return Message(msg : snapshot.data.docs[i],isSender: isSender,);
                  });
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ) 
          ),
        Container(
          color: Colors.white,
           child: SafeArea(
             child: Row(
               children: [
                 Expanded(
                   flex: 4,
                   child: Container(
                     padding: EdgeInsets.all(20),
                     child: TextField(
                     decoration: InputDecoration(
                       hintText: "message",
                       enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(color: Color(
                                      0xff2DBC0E))
                              ),
                       
                     ),
                     controller: messageCon,
                    ),
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: InkWell(
                     child: Container(
                       child: Icon(Icons.send),
                     ),
                     onTap: (){
                       if(messageCon.text.isNotEmpty){
                         setMessage(messageCon.text);
                         messageCon.clear();
                       }
                     },
                   ),
                 )
               ],
             ),
           ),
         )
        ],
      )      
    );
  }
}

// ignore: must_be_immutable
class Message extends StatelessWidget {
  bool isSender;
 final msg ;
 Message({this.msg,required this.isSender});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isSender?CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [ 
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.80,
          ),
          margin: EdgeInsets.only(top: 10,left: 10,right: 10),
          padding: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 12),
          decoration: isSender ? BoxDecoration(
            color: Color(0x97A394FF),
            borderRadius: BorderRadius.circular(30)
          ) :BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text("${msg["message"]}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
          child:Text("${msg["timeh"]}",
            style: TextStyle(
            color: Colors.black45,
            fontSize: 15) ,
          )
        )
      ],
    );
  }
}