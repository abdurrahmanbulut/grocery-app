import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/database.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<AppUser> googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return AppUser('', '', '', '', '', '', Type.none);
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    if(userCredential.user == null){
      return AppUser('', '', '', '', '', '', Type.none);
    }
    final List<AppUser> users = await getAllUsers();
    AppUser user = AppUser(userCredential.user!.uid, '', '', userCredential.user!.email as String, '', '', Type.customer);
    for (var element in users) {
      if(element.email == user.email) {
        user = element;
        break;
      }
    }
    return user;
  }
}


