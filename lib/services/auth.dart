import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userfromFirebase(User user) {
    return MyUser(uid: user.uid);
  }

  //User Stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userfromFirebase(user!));
  }

  //Anonymous Sign-In
  Future signInAnon() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User user = userCredential.user!;
      return _userfromFirebase(user);
    } catch (_) {
      return null;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (_) {
      return null;
    }
  }

  //Register with e-mail
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      //Create a new document with the uid
      await DatabaseService(uid: user.uid).updateUserData('Name', 'Coffee', 0, 100);
      return _userfromFirebase(user);
    } catch (_) {
      return null;
    }
  }

  //Sign In with e-mail
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      return _userfromFirebase(user);
    } catch (_) {
      return null;
    }
  }
}
