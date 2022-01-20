import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/contact_screen.dart';
import 'package:grocery_app/screens/wallet_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/order_history.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  final List<CategoryProduct> categories;
  const AccountScreen(this.categories, {Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: accountView(context),
    );
  }

  Widget accountView(context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.amber,
              ),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Profil",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber,
                  )
                ],
              )),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderHistory()));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.amber,
              ),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Geçmiş Siparişler",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber,
                  )
                ],
              )),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WalletScreen(widget.categories)));
              },
              icon: const Icon(
                Icons.euro,
                color: Colors.amber,
              ),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Cüzdan",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber,
                  )
                ],
              )),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Contact()));
              },
              icon: const Icon(
                Icons.contacts,
                color: Colors.amber,
              ),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("İletişim",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber,
                  )
                ],
              )),
          const Divider(
            height: 15,
            thickness: 2,
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            label: const Text("Çıkış Yap",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(widget.categories)));
            },
          ),
          const SizedBox(height: 80.0),
          SizedBox(
            width: 100.0,
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Emin misiniz?'),
                    content: const Text('Uygulamadan çıkmak mı istiyorsunuz?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hayır'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text('Evet'),
                      ),
                    ],
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text("Uygulamayı Kapat"),
            ),
          ),
        ],
      ),
    );
  }
}
