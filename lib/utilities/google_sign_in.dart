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
    if (googleUser == null) return AppUser('', '', '', '', '', '', Type.none,0);
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    if(userCredential.user == null){
      return AppUser('', '', '', '', '', '', Type.none,0);
    }
    final List<AppUser> users = await getAllUsers();
    AppUser user = AppUser(userCredential.user!.uid, '', '', userCredential.user!.email as String, '', '', Type.customer,0);
    bool _isUser = false;
    for (var element in users) {
      if(element.email == user.email) {
        _isUser=true;
        user = element;
        break;
      }
    }
    if (_isUser==false){
        user.setId(saveUser(user));
        }
    return user;
  }
}


