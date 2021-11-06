import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/screens/profile_screen.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
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
      body: ProfileUpdatePageBody(context),
    );
  }
}

Widget ProfileUpdatePageBody(context) {
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
                  PhotoButton(),
                  const SizedBox(height: 15.0),
                  NameSurname(),
                  const SizedBox(height: 15.0),
                  Username(),
                  const SizedBox(height: 15.0),
                  Email(),
                  const SizedBox(height: 15.0),
                  PhoneNumber(),
                  const SizedBox(height: 20.0),
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

ElevatedButton PhotoButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
    ),
    child: Center(
      child: Container(
        height: 120.0,
        width: 140.0,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/1.jpg'),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          alignment: Alignment.bottomRight,
          //child: expFAB(),
          child: PhotoEditButton(),
        ),
      ),
    ),
    onPressed: () {},
  );
}

ElevatedButton PhotoEditButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(10),
      primary: Colors.amber,
      onPrimary: Colors.amberAccent,
    ),
    child: const Icon(Icons.edit, color: Colors.white),
    onPressed: () {},
  );
}

Widget SubmitButton(context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    width: double.infinity,
    child: RaisedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (MaterialApp(
                    theme: ThemeData.light(), home: ProfileScreen()))));
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

Widget Username() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: const TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(top: 13.0),
            prefixIcon: Icon(
              Icons.account_box,
              color: Colors.amber,
            ),
            hintText: 'Username',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget Email() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: const TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(top: 13.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.amber,
            ),
            hintText: 'E-mail',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget PhoneNumber() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: const TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(top: 13.0),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.amber,
            ),
            hintText: 'Phone Number',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget NameSurname() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 8.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        child: const TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(top: 13.0),
            prefixIcon: Icon(
              Icons.assignment,
              color: Colors.amber,
            ),
            hintText: 'Name and Surname',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}
