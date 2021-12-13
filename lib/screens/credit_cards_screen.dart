import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/adding_credit_card_screen.dart';
import 'package:grocery_app/screens/account_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  _CreditCardsScreenState createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddingCreditCard()));
              },
            ),
          ),
        ],
        title: const Text('Credit Cards',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: CreditCardsView(context),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CreditCardsView(context) {
  return ListView(
    children: [
      CreditCard(context),
      CreditCard(context),
      CreditCard(context),
    ],
  );
}

// ignore: non_constant_identifier_names
Widget CreditCard(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(20, 20, 35, 20),
        padding: const EdgeInsets.all(3.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: const Text(' My Card\n\n XXXX XXXX XXXX XXXX'),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Divider(
          color: Colors.black,
          height: 2,
        ),
      )
    ],
  );
}
