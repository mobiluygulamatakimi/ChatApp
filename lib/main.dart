import 'package:chat_app/add_contact_page.dart';
import 'package:chat_app/contact_page.dart';
import 'package:chat_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(),
    debugShowCheckedModeBanner: false,
    );
  }
}




