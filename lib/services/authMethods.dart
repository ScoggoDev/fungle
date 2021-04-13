import 'package:firebase_auth/firebase_auth.dart';
import 'package:sandbox/modal/user.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  UserConstructor userFromFirebaseUser(User user) {
    return user !=null ? UserConstructor(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = credential.user;
      return userFromFirebaseUser(firebaseUser);

    }
    catch (e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = credential.user;
      return userFromFirebaseUser(firebaseUser);
    }
    catch (e){
      print (e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    
    }
  catch (e) {
    print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    }
    catch (e){
      print(e.toString());
    }
  }

}