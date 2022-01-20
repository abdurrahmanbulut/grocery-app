import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/cart/components/body.dart';
import 'package:grocery_app/screens/payment_screen.dart';
import 'package:grocery_app/services/database.dart';

class CartScreen extends StatelessWidget {
  final List<CategoryProduct> categories;
  static String routeName = "/cart";

  CartScreen(this.categories, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOurCard(categories),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const Center(
            child: Text(
              "Sepetim",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: appUser.sumOfCart,
            builder: (context, value, widget) {
              return Text("(${appUser.carts.length} ürün)",
                  style: const TextStyle(fontSize: 15, color: Colors.black)
                  //style: Theme.of(context).textTheme.caption,
                  );
            },
          ),
        ],
      ),
    );
  }
}

class CheckOurCard extends StatefulWidget {
  final List<CategoryProduct> categories;

  CheckOurCard(this.categories,{Key? key,}) : super(key: key);

  @override
  State<CheckOurCard> createState() => _CheckOurCardState();
}

class _CheckOurCardState extends State<CheckOurCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appUser.sumOfCart,
      builder: (context, value, widget) {
        return checkedCard();
      },
    );
  }

  Widget checkedCard() {
    appUser.sumCart();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: Colors.grey.withOpacity(0.15),
            )
          ]),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(text: "Total:\n", children: [
                TextSpan(
                    text: "${appUser.sumOfCart.value} TL",
                    style: const TextStyle(fontSize: 22, color: Colors.black))
              ])),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentScreen(widget.categories)));
                      },
                      child: const Text(
                        "Ödemeye git",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      )))
            ],
          )
        ],
      ),
    );
  }
}
