import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  final List<CategoryProduct> categories;
  const OnBoardingPage(this.categories,{Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SplashScreen(widget.categories)),
    );
  }

  Widget _buildFullscreenImage(String assetName) {
    return Image.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      titlePadding: EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 0.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          child: ElevatedButton(
            child: const Text(
              'Başlayalım!',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "İstediği Ara.",
          body: "Sepetinizi doldurun ve gelip alın.",
          image: _buildFullscreenImage('images/1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Sepetinizi Hazırlıyoruz.",
          body: "Zaman harcamanıza gerek yok.",
          image: _buildFullscreenImage('images/2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Size bildireceğiz",
          body:
              "Siparişinizi almak için size QR Kod veriyoruz.",
          image: _buildFullscreenImage('images/3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Siparişinizi alın",
          body:
              "Size verdiğimiz kodu okutarak siparişinizi teslim alabilirsiniz.",
          image: _buildFullscreenImage('images/5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Eğer heyecanlı iseniz!",
          body: "Hemen başlayalım.",
          image: _buildFullscreenImage('images/4.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Atla',
        style: TextStyle(color: Colors.black),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text(
        'Bitti',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
