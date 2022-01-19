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
import 'package:shared_preferences/shared_preferences.dart';
import 'cashier_home_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  final List<CategoryProduct> categories;
  const LoginScreen(this.categories, {Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  bool isLoading = false;
  bool _isObscure = true;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? error = null;

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  Future<void> _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String rememberedEmail = (_prefs.getString("email") != null)
          ? _prefs.getString("email") as String
          : "";
      String rememberedPassword = (_prefs.getString("password") != null)
          ? _prefs.getString("password") as String
          : "";
      bool _rememberMe = (_prefs.getBool("remember_me") != null)
          ? _prefs.getBool("remember_me") as bool
          : false;
      if (_rememberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text =
            rememberedEmail.isNotEmpty ? rememberedEmail : "";
        _passwordController.text =
            rememberedPassword.isNotEmpty ? rememberedPassword : "";
        _email = rememberedEmail.isNotEmpty ? rememberedEmail : "";
        _password = rememberedPassword.isNotEmpty ? rememberedPassword : "";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
    logout();
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
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 50, child: ShowAlert()),
                            const SizedBox(
                              width: 65,
                              height: 10,
                            ),
                            const SizedBox(height: 5.0),
                            Center(child: buildAnimatedText(3)),
                            const SizedBox(height: 5.0),
                            _buildEmailTF(), // email widget
                            const SizedBox(
                              height: 15.0,
                            ),
                            _buildPasswordTF(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                ),
                                _buildRememberMeCheckbox(),
                                SizedBox(
                                  width: 40,
                                ),
                                _buildForgotPasswordBtn(),
                              ],
                            ),
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
                            const SizedBox(height: 25.0),
                          ],
                        ),
                      ),
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          width: 300,
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
          width: 300,
          child: TextFormField(
            controller: _passwordController,
            obscureText: _isObscure,
            style: const TextStyle(
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
              suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
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

  Widget buildAnimatedText(int num) {
    if (num == 0) {
      return SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            color: Colors.amber,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText('Welcome to Grocery!'),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      );
    } else if (num == 1) {
      return SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('do IT!'),
              FadeAnimatedText('do it RIGHT!!'),
              FadeAnimatedText('do it RIGHT NOW!!!'),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      );
    } else if (num == 3) {
      const colorizeColors = [
        Colors.amber,
        Colors.blue,
        Colors.purple,
        Colors.red,
      ];

      const colorizeTextStyle = TextStyle(
        fontSize: 25.0,
        fontFamily: 'Horizon',
      );

      return SizedBox(
        width: 250.0,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Welcome to Grocery!',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
      );
    }
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
              value: _isChecked,
              checkColor: Colors.black,
              activeColor: Colors.amber,
              onChanged: (value) {
                _handleRemeberme(value!);
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
      width: 300,
      child: RaisedButton(
        onPressed: () async {
          try {
            appUser = await signInWithEmail(_email, _password);
            if (auth.currentUser!.email == _email) {
              AppUser checkedUser = await checkUser(appUser);
              checkedUser.setId(appUser.dataId);
              appUser = checkedUser;
              if (appUser.type == Type.customer) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(widget.categories)));
              } else if (appUser.type == Type.cashier) {
                List<Order> temporders = await getAllOrders();
                List<Order> TodaysOrders = TodaysOrdersFunc(temporders);
                List<Order> orders = await getAllOrders();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CashierHomeScreen(
                            widget.categories, orders, TodaysOrders)));
              }
            }
          } on FirebaseAuthException catch (e) {
            setState(() {
              print(e.message);
              switch (e.message) {
                case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                  error =
                      "There is no user record corresponding to this identifiers";
                  break;
                case 'The password is invalid or the user does not have a password.':
                  error = "The password is invalid!";
                  break;
                case 'Given String is empty or null':
                  error = "Email or password can not be empty!";
                  break;
                case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                  error = "There is a network error.Please try again later!";
                  break;
                default:
                  error = "Error";
              }
            });
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

  Widget ShowAlert() {
    if (error != null) {
      return Container(
        color: Colors.red,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                error.toString(),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    print("object");
                    error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
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

  Container googleButton() {
    return Container(
      width: 300,
      height: 50,
      child: OutlinedButton(
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
            appUser = await googleSignInProvider.googleLogIn();
            AppUser checkedUser = await checkUser(appUser);
            checkedUser.setId(appUser.dataId);
            appUser = checkedUser;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(widget.categories)));
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
      ),
    );
  }

  Container _signUpButton() {
    return Container(
      height: 50.0,
      width: 300,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterScreen(widget.categories)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              width: 30,
            ),
            Text('Don\'t you have an account? SIGN UP',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                )),
          ],
        ),
      ),
    );
  }

  Container _testCustomerLogin() {
    return Container(
        height: 50.0,
        width: 300,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          onPressed: () async {
            String _testEmail = 'metegoncaq@gmail.com';
            String _testPassword = '123456789';
            appUser = await signInWithEmail(_testEmail, _testPassword);
            AppUser checkedUser = await checkUser(appUser);
            checkedUser.setId(appUser.dataId);
            appUser = checkedUser;
            if (auth.currentUser!.email == _testEmail) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(widget.categories)));
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
        ));
  }

  Container _testCashierLogin() {
    return Container(
      height: 50.0,
      width: 300,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black, width: 2),
        ),
        onPressed: () async {
          String _testEmail = 'dogukaanguleer@gmail.com';
          String _testPassword = '123456';
          appUser = await signInWithEmail(_testEmail, _testPassword);
          AppUser checkedUser = await checkUser(appUser);
          List<Order> temporders = await getAllOrders();
          List<Order> TodaysOrders = TodaysOrdersFunc(temporders);
          List<Order> orders = await getAllOrders();
          checkedUser.setId(appUser.dataId);
          appUser = checkedUser;
          if (auth.currentUser!.email == _testEmail) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CashierHomeScreen(
                        widget.categories, orders, TodaysOrders)));
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
      ),
    );
  }
}

List<Order> TodaysOrdersFunc(List<Order> orders) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  int count = 0;
  for (int i = 0; i < orders.length; i++) {
    String tempDate = orders[i].time.toString();
    String date = tempDate.substring(0, 10);
    if (date != formattedDate) {
      count = i;
    }
  }
  List<Order> AllOrders = orders;
  AllOrders.removeRange(0, count + 1);
  return AllOrders;
}
