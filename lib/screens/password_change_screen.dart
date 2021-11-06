import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screens/profile_screen.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Change Password',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: passwordChangeView(context),
    );
  }
}

Widget passwordChangeView(context) {
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
          Container(
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
                  CurrentPassword(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  NewPassword(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ConfirmPassword(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SubmitButton(context),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget CurrentPassword() {
  var kHintTextStyle;
  var kBoxDecorationStyle;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: TextField(
          obscureText: true,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(top: 13.0),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.amber,
            ),
            hintText: 'Current Password',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget NewPassword() {
  var kHintTextStyle;
  var kBoxDecorationStyle;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: TextField(
          obscureText: true,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(top: 13.0),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.amber,
            ),
            hintText: 'New Password',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget ConfirmPassword() {
  var kHintTextStyle;
  var kBoxDecorationStyle;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: TextField(
          obscureText: true,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(top: 13.0),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.amber,
            ),
            hintText: 'Confirm Password',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget SubmitButton(context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0),
    width: double.infinity,
    child: RaisedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (MaterialApp(
                    theme: ThemeData.light(), home: const ProfileScreen()))));
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
