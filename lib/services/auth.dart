import 'package:coffeealert/models/custom_user.dart';
import 'package:coffeealert/services/firebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
      // setting new collection of user data in firestor
      FirebaseService(uid: user.uid).updateData(
          imgUrl: user.photoURL ??
              "https://e7.pngegg.com/pngimages/981/645/png-clipart-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette.png",
          name: user.displayName,
          sugar: "2",
          strength: 100);

      return user;
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

  Future signInWithFacebook() async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.Success:
        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final result = await _auth.signInWithCredential(credential);

        final user = result.user;
        // setting new collection of user data in firestor
        FirebaseService(uid: user.uid).updateData(
            imgUrl: user.photoURL ??
                "https://e7.pngegg.com/pngimages/981/645/png-clipart-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette.png",
            name: user.displayName,
            sugar: "2",
            strength: 100);
        return user;

        break;
      case FacebookLoginStatus.Cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.Error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
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
    UserCredential userCredential = await _auth.signInAnonymously();
    User user = userCredential.user;
    return _userFromFirebase(user);
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
  Future<CustomUser> registerWithEmail(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = userCredential.user;
    // setting new collection of user data in firestor
    FirebaseService(uid: user.uid).updateData(
        imgUrl: user.photoURL ??
            "https://e7.pngegg.com/pngimages/981/645/png-clipart-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette.png",
        name: user.email,
        sugar: "2",
        strength: 100);
    return _userFromFirebase(user);
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

  // Password reset
  Future resetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
