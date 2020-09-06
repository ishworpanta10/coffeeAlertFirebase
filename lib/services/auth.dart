import 'package:coffeealert/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function to change Firebase User To custom User type
  CustomUser _userFromFirebase(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // sign in anonm
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print("Anon Sign In Error: $e");
      return null;
    }
  }

  // sign in with email and psswd

  // register with email and psswd

  // sign out

}
