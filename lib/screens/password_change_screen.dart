import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  String _current = '', _new = '', _confirm = '';
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Şifre Değiştir',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: passwordChangeView(context),
    );
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
                    currentPassword(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    newPassword(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    confirmPassword(),
                    const SizedBox(
                      height: 15.0,
                    ),
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

  Widget currentPassword() {
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
              controller: _currentController,
              obscureText: _isObscure,
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
                hintText: 'Kullanılan Şifre',
                hintStyle: kHintTextStyle,
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
              ),
              onChanged: (value) {
                setState(() {
                  _current = value;
                });
              }),
        ),
      ],
    );
  }

  Widget newPassword() {
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
              controller: _newController,
              obscureText: _isObscure3,
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
                suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure3 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure3 = !_isObscure3;
                      });
                    }),
                hintText: 'Yeni Şifre',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (value) {
                setState(() {
                  _new = value;
                });
              }),
        ),
      ],
    );
  }

  Widget confirmPassword() {
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
              controller: _confirmController,
              obscureText: _isObscure2,
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
                suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure2 ? Icons.visibility : Icons.visibility_off,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure2 = !_isObscure2;
                      });
                    }),
                hintText: 'Şifre Doğrulama',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (value) {
                setState(() {
                  _confirm = value;
                });
              }),
        ),
      ],
    );
  }

  Widget submitButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (appUser.password == _current) {
            if (_new == _confirm) {
              passwordChange(appUser, _new);
              Navigator.of(context).pop();
            }
          }
        },
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.amber,
        child: const Text(
          'Gönder',
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
