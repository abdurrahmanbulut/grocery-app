import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'package:grocery_app/utilities/extensions.dart';

class RegisterScreen extends StatefulWidget {
  final List<CategoryProduct> categories;
  const RegisterScreen(this.categories, {Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  bool _isObscure = true;
  final auth = FirebaseAuth.instance;
  String _confirm = '', _email = '', _password = '';
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Kayıt Ol',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: registerPageBody(),
    );
  }

  Widget registerPageBody() {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Stack(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      height: 70.0,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (input) =>
                            input!.isValidEmail() ? null : "Email Yanlış!",
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
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      height: 70.0,
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (input) => input!.isValidPassword()
                              ? null
                              : "Şifreniz 6-10 karakter içermelidir.",
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
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            hintText: 'Şifre',
                            hintStyle: kHintTextStyle,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      height: 70.0,
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (input) => (input == _password)
                              ? null
                              : "Şifre Eşleşmiyor!",
                          controller: _confirmController,
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
                            hintText: 'Şifreyi Tekrar Giriniz',
                            hintStyle: kHintTextStyle,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _confirm = value;
                            });
                          }),
                    ),
                  ],
                ), // email widget
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_email.isValidEmail() &&
                          _password.isValidPassword() &&
                          _password == _confirm) {
                        appUser = await createUserWithEmail(_email, _password);
                        appUser = await signInWithEmail(_email, _password);
                        AppUser checkedUser = await checkUser(appUser);
                        checkedUser.setId(appUser.dataId);
                        appUser = checkedUser;
                          auth.signOut();
                          Navigator.pop(context);
                      }
                    },
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.amber,
                    child: const Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        )
      ],
    );
  }
}
