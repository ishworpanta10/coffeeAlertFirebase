import 'package:coffeealert/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future<User> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken);
  //   final UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);

  //   final User user = userCredential.user;
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final User currentUser = _auth.currentUser;
  //   assert(user.uid == currentUser.uid);
  //   print("ignInWithGoogle succeeded: $user");

  //   return user;
  // return 'signInWithGoogle succeeded: $user';
  // }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user;
      print("Logged in user : ${user.displayName}");
      return user;
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

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
  Future<CustomUser> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print("Email Sign In Error: $e");
      return null;
    }
  }

  // register with email and psswd
  Future registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print("Email Register Error: ${e.toString()}");
      return null;
    }
  }

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
