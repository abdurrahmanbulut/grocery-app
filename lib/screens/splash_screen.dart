import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'introduction_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  final List<CategoryProduct> categories;
  const Splash(this.categories,{Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen(widget.categories)));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingPage(widget.categories)));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Yükleniyor...'),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final List<CategoryProduct> categories;
  const SplashScreen(this.categories,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(238, 186, 43, 0.9),
        splash: Image.asset('./assets/images/logo.png'),
        nextScreen:  LoginScreen(categories),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 130.0,
        duration: 1000,
      ),
    );
  }
}
