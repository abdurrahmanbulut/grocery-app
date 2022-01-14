import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/model/user.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future uploadImageToFirebase(BuildContext context,File _image,AppUser user) async {
  Reference ref = storage.ref().child('profiles').child(user.dataId.key);
  UploadTask uploadTask = ref.putFile(_image);
  uploadTask.then((res) async {
    user.image = await res.ref.getDownloadURL();
  });
  user.update();
}