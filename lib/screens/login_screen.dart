import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/notification.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/forgot_password_screen.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/screens/register_screen.dart';
import 'package:grocery_app/utilities/google_sign_in.dart';
import 'cashier_home_screen.dart';

class LoginScreen extends StatefulWidget {
  final List<CategoryProduct> categories;
  const LoginScreen(this.categories,{Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
  Remember remember = Remember('', '');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  _asyncGetRemember() async {
    remember = await getRemember();
  }
  @override
  void initState() {
    _asyncGetRemember();

    super.initState();
    logout();
    if (remember.email != '' && remember.password != '') {
      _emailController.value = _emailController.value.copyWith(
        text: remember.email,
        selection: TextSelection(
            baseOffset: remember.email.length,
            extentOffset: remember.email.length),
        composing: TextRange.empty,
      );
      _passwordController.value = _passwordController.value.copyWith(
        text: remember.password,
        selection: TextSelection(
            baseOffset: remember.password.length,
            extentOffset: remember.password.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  child: Form(
                    key: _formKey,
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
                        _signUpButton(),
                        const SizedBox(height: 25.0),
                        _testCustomerLogin(),
                        const SizedBox(height: 25.0),
                        _testCashierLogin(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
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
              hintStyle: kLabelStyle,
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

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.amber,
              ),
              hintText: 'Password',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
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
        onPressed: () async {
          AppUser user = await signInWithEmail(_email, _password);
          if (auth.currentUser!.email == _email) {
            if (_rememberMe) {
              await saveRemember(Remember(_email,_password));
            }
            else {
              await saveRemember(Remember('',''));
            }
            if(user.type == Type.customer) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (MaterialApp(
                          theme: ThemeData.light(), home: HomeScreen(user,widget.categories)))));
            }
            else if(user.type == Type.cashier) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (MaterialApp(
                          theme: ThemeData.light(), home: CashierHomeScreen(user,widget.categories)))));
            }
          }
          else {

          }
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
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        try {
          AppUser user = await googleSignInProvider.googleLogIn() ;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user,widget.categories)));
        } catch (e) {
          if (e is FirebaseAuthException) {
            throw e;
          }
        }
        setState(() {
          isLoading = false;
        });
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

  OutlinedButton _signUpButton() {
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
                    theme: ThemeData.light(), home: RegisterScreen(widget.categories)))));
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
  Widget _testCustomerLogin() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      onPressed: () async {
        String _testEmail = 'metegoncaq@gmail.com';
        String _testPassword = '123456789';
        AppUser user = await signInWithEmail(_testEmail, _testPassword);
        if (auth.currentUser!.email == _testEmail) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (MaterialApp(
                      theme: ThemeData.light(), home: HomeScreen(user,widget.categories)))));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 80,
          ),
          Text('Customer Test Sign In',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              )),
        ],
      ),
    );
  }
  Widget _testCashierLogin() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      onPressed: () async {
        String _testEmail = 'dogukaanguleer@gmail.com';
        String _testPassword = '123456';
        AppUser user = await signInWithEmail(_testEmail, _testPassword);
        if (auth.currentUser!.email == _testEmail) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (MaterialApp(
                      theme: ThemeData.light(), home: CashierHomeScreen(user,widget.categories)))));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 80,
          ),
          Text('Cashier Test Sign In',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              )),
        ],
      ),
    );
  }
}
