import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/utilities/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Sign Up',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: registerPageBody(),
    );
  }

  Widget registerPageBody() {
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
                    username(), // email widget
                    const SizedBox(
                      height: 15.0,
                    ),
                    email(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    password(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    signUpButton(),
                    or(),
                    googleButton(),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
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
              hintStyle: kLabelStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
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
              hintStyle: kLabelStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget password() {
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
                Icons.lock,
                color: Colors.amber,
              ),
              hintText: 'Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget signUpButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (MaterialApp(
                      theme: ThemeData.light(), home: const HomeScreen()))));
        },
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.amber,
        child: const Text(
          'Sign Up',
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
}

OutlinedButton googleButton() {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.white,
      side: const BorderSide(color: Colors.black, width: 2),
    ),
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(7.0),
          height: 25.0,
          width: 25.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logos/google.jpg'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 58,
        ),
        const Text(
          "Sign Up with Google",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        )
      ],
    ),
  );
}

Widget or() {
  var kLabelStyle;
  return Column(
    children: <Widget>[
      Text(
        'Or',
        style: kLabelStyle,
      ),
      const SizedBox(
        height: 10.0,
      )
    ],
  );
}
