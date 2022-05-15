import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_contact_page.dart';
import 'models/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late List<Contact> contacts;
  @override
  void initState() {
    contacts = Contact.contacts;
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts
        .sort((Contact a, Contact b) => a.name[0].compareTo(b.name[0]));
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişilerim"),
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddContactPage()));
          },
          child: Icon(Icons.add)),
      body: Container(
        child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = contacts[index];
              return Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn.wallpapersafari.com/27/13/KCqWxQ.jpg"),
                        child: Text(contact.name[0])),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contact.name),
                          Text(contact.phoneNumber),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
      // bottomSheet: BottomNavBarFb1(),
    );
  }
}
