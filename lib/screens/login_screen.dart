import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screens/forgot_password_screen.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/utilities/google_sign_in.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  Widget _buildEmailTF() {
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
              hintText: 'Username / E-mail',
              hintStyle: kLabelStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ForgotPassword()))
        }, //print('Forgot Password Button Pressed'),
        padding: const EdgeInsets.only(right: 0.0),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.amber),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.white,
              activeColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
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
          'Sign In',
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

  Widget _or() {
    return Column(
      children: const <Widget>[
        Text(
          'Or',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  OutlinedButton googleButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      onPressed: () {
        final provider= Provider.of<GoogleSignInProvider>(context, listen: false );
        provider.googleLogIn();
        /*Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));*/

      },
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
            "Sign In with Google",
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

  OutlinedButton _signUpButon() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (MaterialApp(
                    theme: ThemeData.light(), home: const RegisterScreen()))));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 35,
          ),
          Text('Don\'t you have an account? SIGN UP',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Sign In',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      _buildEmailTF(), // email widget
                      const SizedBox(
                        height: 15.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _or(),
                      googleButton(),
                      const SizedBox(height: 25.0),
                      //_text2(),
                      _signUpButon(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
