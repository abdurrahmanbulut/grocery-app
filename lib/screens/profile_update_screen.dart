import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/services/cloud.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'package:grocery_app/utilities/extensions.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final AppUser user;
  const ProfileUpdateScreen(this.user,{Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  String _email = '', _name = '', _phone = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
      _emailController.value = _emailController.value.copyWith(
        text: widget.user.email,
        selection:
        TextSelection(baseOffset: widget.user.email.length, extentOffset: widget.user.email.length),
        composing: TextRange.empty,
      );
      _nameController.value = _nameController.value.copyWith(
        text: widget.user.name,
        selection:
        TextSelection(baseOffset: widget.user.name.length, extentOffset: widget.user.name.length),
        composing: TextRange.empty,
      );
      _phoneController.value = _phoneController.value.copyWith(
        text: widget.user.phoneNumber,
        selection:
        TextSelection(baseOffset: widget.user.phoneNumber.length, extentOffset: widget.user.phoneNumber.length),
        composing: TextRange.empty,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Update Profile',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: profileUpdatePageBody(context),
    );
  }

  Widget profileUpdatePageBody(context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 65.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 5.0),
                    photoButton(),
                    const SizedBox(height: 15.0),
                    nameSurname(),
                    const SizedBox(height: 15.0),
                    email(),
                    const SizedBox(height: 15.0),
                    phoneNumber(),
                    const SizedBox(height: 20.0),
                    submitButton(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton photoButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Container(
          height: 120.0,
          width: 140.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (widget.user.image.isEmpty)? const AssetImage('assets/images/1.jpg') : Image.network(widget.user.image).image,
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            alignment: Alignment.bottomRight,
            //child: expFAB(),
            child: photoEditButton(),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  ElevatedButton photoEditButton() {
    File _imageFile = File("");
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        primary: Colors.amber,
        onPrimary: Colors.amberAccent,
      ),
      child: const Icon(Icons.edit, color: Colors.white),
      onPressed: () async {
        final ImagePicker _picker = ImagePicker();
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _imageFile = File(image!.path);
        });
        uploadImageToFirebase(context,_imageFile,widget.user);
      },
    );
  }

  Widget submitButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if(_name.isNotEmpty) {
            widget.user.name = _name;
          }
          if(_phone.isNotEmpty && _phone.isPhoneNumber()) {
            widget.user.phoneNumber = _phone;
          }
          if(_email.isNotEmpty && _email.isValidEmail()) {
            emailChange(widget.user, _email);
          }
          widget.user.update();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (MaterialApp(
                      theme: ThemeData.light(), home: ProfileScreen(widget.user)))));
        },
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.amber,
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 70.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.always,
            validator: (input) => input!.isValidEmail() ? null : "Email is invalid",
            controller: _emailController,
            obscureText: false,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.amber,
              ),
              hintText: 'E-mail',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget phoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 70.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.always,
            validator: (input) => (input!.isPhoneNumber()) ? null : "Phone number is invalid",
            controller: _phoneController,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.amber,
              ),
              hintText: 'Phone Number',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              setState(() {
                _phone = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget nameSurname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 70.0,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: _nameController,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.assignment,
                color: Colors.amber,
              ),
              hintText: 'Name and Surname',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
        ),
      ],
    );
  }


}

