import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cart/components/body.dart';
import 'package:grocery_app/screens/cart/components/cart_card.dart';

class CartScreen extends StatelessWidget {
  final AppUser user;
  final List<CategoryProduct> categories;
  static String routeName = "/cart";

  const CartScreen(this.user,this.categories,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: const CheckOurCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const Center(
            child: Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            "(${demoCarts.length} items)",
              style: const TextStyle(fontSize: 15,color: Colors.black)
            //style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class CheckOurCard extends StatefulWidget {
  const CheckOurCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckOurCard> createState() => _CheckOurCardState();
}

class _CheckOurCardState extends State<CheckOurCard> {
  @override
  Widget build(BuildContext context) {
    double sum = 0;
    setState(() {
      for (int i = 0; i < demoCarts.length; i++) {
        sum += (demoCarts[i].product.price * demoCarts[i].numOfItem);
      }
    });
    print("  wqqq " + sum.toString());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Colors.grey.withOpacity(0.15),
            )
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset("assets/icons/discount.svg"),
              ),
              const Spacer(),

              const Text("Add voucher code"),

              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.amber),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text.rich(TextSpan(text: "Total:\n", children: [
                TextSpan(
                    text:"\$$sum",
                    style: TextStyle(fontSize: 22, color: Colors.black))
              ])),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {
                        print("pressed");
                      },
                      child: const Text(
                        "Check Out",
                        style: TextStyle(fontSize: 18,color: Colors.white),
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
