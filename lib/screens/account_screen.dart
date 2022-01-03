import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/contact_screen.dart';
import 'package:grocery_app/screens/credit_cards_screen.dart';
import 'package:grocery_app/screens/favorites_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/order_history.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  final List<CategoryProduct> categories;
  const AccountScreen( this.categories, {Key? key}) : super(key: key);

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.amber,
              ),
              label: Row(
                children: const [
                  Text(
                      "Profile                                                ",
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
                children: const [
                  Text("Previous Orders                               ",
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
                    MaterialPageRoute(builder: (context) => Favorites()));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.amber,
              ),
              label: Row(
                children: const [
                  Text("Favorites                                           ",
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
                        builder: (context) => CreditCardsScreen()));
              },
              icon: const Icon(
                Icons.credit_card,
                color: Colors.amber,
              ),
              label: Row(
                children: const [
                  Text("Cards                                                 ",
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
                children: const [
                  Text("Contact                                             ",
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
            label: const Text("Sign Out",
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
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to close the App'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text("Close App"),
            ),
          ),
        ],
      ),
    );
  }
}
