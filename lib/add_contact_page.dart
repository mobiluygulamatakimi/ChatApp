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
<<<<<<< HEAD
                      decoration: const InputDecoration(hintText: "Kişi Adı"),
                      validator: (String? value) {
=======
<<<<<<< HEAD
                      decoration: const InputDecoration(hintText: "Kişi Adı"),
                      validator: (String? value) {
=======
                      decoration: InputDecoration(hintText: "Kişi Adı"),
                      validator: (value) {
>>>>>>> fbd9bd9fd83a449b44d3b34f90101c1316f6d296
>>>>>>> 17cb7fd166c10552f893b5553aa69bf4b10acfa4
                        if (value!.isEmpty) {
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Contact.contacts
                          .add(Contact(name: name!, phoneNumber: phoneNumber!));
                      var snackbar = Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("${name} kaydedildi")));

                      snackbar.closed.then((value) => Navigator.pop(context));
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ]),
        ));
  }
}
