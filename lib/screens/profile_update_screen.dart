import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/services/cloud.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/extensions.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

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
      text: appUser.email,
      selection: TextSelection(
          baseOffset: appUser.email.length, extentOffset: appUser.email.length),
      composing: TextRange.empty,
    );
    _nameController.value = _nameController.value.copyWith(
      text: appUser.name,
      selection: TextSelection(
          baseOffset: appUser.name.length, extentOffset: appUser.name.length),
      composing: TextRange.empty,
    );
    _phoneController.value = _phoneController.value.copyWith(
      text: appUser.phoneNumber,
      selection: TextSelection(
          baseOffset: appUser.phoneNumber.length,
          extentOffset: appUser.phoneNumber.length),
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
                    (appUser.password.isNotEmpty) ? email() : Container(),
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
              image: (appUser.image.isEmpty)
                  ? const AssetImage('assets/images/1.jpg')
                  : Image.network(appUser.image).image,
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
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _imageFile = File(image!.path);
        });
        uploadImageToFirebase(context, _imageFile, appUser);
      },
    );
  }

  Widget submitButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (_name.isNotEmpty) {
            appUser.name = _name;
          }
          if (_phone.isNotEmpty && _phone.isPhoneNumber()) {
            appUser.phoneNumber = _phone;
          }
          if (_email.isNotEmpty && _email.isValidEmail()) {
            emailChange(appUser, _email);
          }
          appUser.update();
          Navigator.of(context).pop();
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) =>
                input!.isValidEmail() ? null : "Email is invalid",
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) =>
                (input!.isPhoneNumber()) ? null : "Phone number is invalid",
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
