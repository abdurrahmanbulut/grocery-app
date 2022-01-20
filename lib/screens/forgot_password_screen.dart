import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth = FirebaseAuth.instance;
  String _email = '';
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const Text('Şifre Sıfırlama',
              style:
              TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Lütfen Email Giriniz'),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            SizedBox(
              width: 250.0,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Tamamlandı!'),
                      content: const Text(
                          'Eposta mailinize gönderilmiştir. Lütfen kontrol ediniz!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Gönder"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
