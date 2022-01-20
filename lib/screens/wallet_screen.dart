import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/model/wallet_transaction.dart';
import 'package:grocery_app/screens/account_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/services/database.dart';
import 'package:intl/intl.dart';
import 'package:grocery_app/services/auth.dart';

class WalletScreen extends StatefulWidget {

  final List<CategoryProduct> categories;
  const WalletScreen(this.categories,{Key? key}) : super(key: key);

  @override

  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Wallet',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
              child: colorCard("Bakiye:", appUser.wallet, 1, context,
                  Color(0xFFFFC107))),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: WalletWiev(context),
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget WalletWiev(context) {
  final List<CategoryProduct> categories;
  int long = appUser.walletTransactions.length;
  return ListView(
    children: [for (int i = 0; i < long; i++) WalletHistory(context, i)],
  );
}

// ignore: non_constant_identifier_names
Column WalletHistory(context, int data) {
  DateTime now = appUser.walletTransactions[data].time;
  String formattedDate = DateFormat('EEE d MMM yyyy kk:mm:ss').format(now);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //userInformation("Coin have been bought from: ", appUser.walletTransactions[data].sellerId),
      userInformation(
          "Coin Amount :", appUser.walletTransactions[data].price.toString()),
      userInformation(
          "Process Time: ", formattedDate),       
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Divider(
          color: Colors.black,
          height: 10,
        ),
      )
    ],
  );
}

Row userInformation(String title, String info) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      Text(info, style: const TextStyle(fontSize: 17))
    ],
  );
}

Widget colorCard(
    String text, double amount, int type, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 15, right: 15),
    padding: EdgeInsets.all(15),
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: 0.2,
              offset: Offset(0, 8)),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${type > 0 ? "" : "-"}  ${amount.toString()} TL",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
