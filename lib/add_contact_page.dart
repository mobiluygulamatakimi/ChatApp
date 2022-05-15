import 'package:chat_app/models/contact.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Contact.contacts.add(Contact(name: "Test", phoneNumber: "555 555 5555"));
    print(Contact.contacts.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Kişi Ekle"),
      ),
      body: AddContactForm(),
    );
  }
}

class AddContactForm extends StatefulWidget {
  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String? name;
    String? phoneNumber;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Kişi Adı"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "İsim Gerekli";
                        }
                      },
                      onSaved: (value) {
                        name = value;
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Telefon Numarası"),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        phoneNumber = value;
                      },
                    )),
                RaisedButton(
                  child: Text("Kaydet"),
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ]),
        ));
  }
}
