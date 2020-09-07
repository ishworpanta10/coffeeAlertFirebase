import 'package:coffeealert/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function to change Firebase User To custom User type
  CustomUser _userFromFirebase(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // stream to find auth state
  Stream<CustomUser> get user {
    return _auth
        .authStateChanges()
        // ..listen((User user) {
        //   if (user != null) {
        //     print('Logged In User is : ${user.uid}');
        //   } else {
        //     print('User is currently sign out');
        //   }
        // })
        // .map((User user) => _userFromFirebase(user));   same as down line
        .map(_userFromFirebase);
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
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error in Log Out : ${e.toString()}");
      return null;
    }
  }
}
