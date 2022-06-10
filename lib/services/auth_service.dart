import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  // Future<String> singIn({String email, required String password}) {}
}

Future<void> main() async {
  await Firebase.initializeApp();
}
