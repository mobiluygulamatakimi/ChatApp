import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kjlchat/Server/auth.dart';

// ignore: camel_case_types
class forgotPass extends StatefulWidget {
  @override
  _forgotPassState createState() => _forgotPassState();
}
// ignore: camel_case_types
class _forgotPassState extends State<forgotPass> {

  final TextEditingController emailCon=TextEditingController();
  AuthServer authServer=AuthServer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                "reset_password".tr(), 
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,letterSpacing: 1,
                  fontFamily: "arefRuqaa"
                ),
              ),
              centerTitle: true,
              backgroundColor: Color(0xff2DBC0E),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: "email".tr(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Color(
                          0xff2DBC0E))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Color(
                          0xff2DBC0E))
                  )
              ),
              controller: emailCon,
            ),
            SizedBox(height: 20,),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Color(0xff2DBC0E),
              onPressed: (){
                // ignore: unnecessary_null_comparison
                if(emailCon.text!=null){
                  authServer.ResetPass(emailCon.text, context);
                }
              },
              child: Text("send".tr()),
              textColor: Colors.white,
            ),
          ],
        ),
      )
    );
  }
}