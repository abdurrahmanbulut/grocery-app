import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/model/user.dart';

import 'cloud.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<AppUser> signInWithEmail(String _email,String _password) async {
  final List<AppUser> users = await getAllUsers();
  AppUser user = AppUser('', '', '', _email, _password, '', Type.customer,0.0);
  if(users.isEmpty) {
    return user;
  }
  for (var element in users) {
    if(element.email == user.email) {
      user = element;
      break;
    }
  }
  await _auth.signInWithEmailAndPassword(email: _email, password: _password);
  user.image = await storage.ref().child('profiles').child(user.dataId.key).getDownloadURL();
  return user;
}

Future checkUser(AppUser user) async {
  final List<AppUser> users = await getAllUsers();
  AppUser checkedUser = AppUser('', '', '', '', '', '', Type.none,0.0);
  if(users.isEmpty) {
    return user;
  }
  for (var element in users) {
    if(element.email == user.email) {
      checkedUser = element;
      break;
    }
  }
  checkedUser.setId(user.dataId);
  checkedUser.image = user.image;
  return checkedUser;
}

Future<AppUser> createUserWithEmail(String _email,String _password) async {
  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
  AppUser user = AppUser(userCredential.user!.uid, '', '', _email, _password, '', Type.customer,0.0);
  user.setId(saveUser(user));
  return user;
}

Future logout() async {
  FirebaseAuth.instance.signOut();
}

Future passwordChange(AppUser appUser,String _password) async {
  appUser.password = _password;
  appUser.update();
  User? user = _auth.currentUser;
  user!.updatePassword(_password);
}

Future emailChange(AppUser appUser,String _email) async {
  appUser.email = _email;
  appUser.update();
  User? user = _auth.currentUser;
  user!.updateEmail(_email);
}