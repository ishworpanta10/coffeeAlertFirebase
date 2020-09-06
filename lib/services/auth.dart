import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anonm
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return user;
    } catch (e) {
      print("Anon Sign In Error: $e");
      return null;
    }
  }

  // sign in with email and psswd

  // register with email and psswd

  // sign out

}
