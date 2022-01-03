import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/services/database.dart';

class PaymentScreen extends StatefulWidget {
  final List<CategoryProduct> categories;

  PaymentScreen(this.categories, {Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Apply Payment',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: payment_Screen(),
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
          /* ValueListenableBuilder(
            valueListenable: user.sumOfCart,
            builder: (context, value, widget) {
              return Text("(${user.carts.length} items)",
                  style: const TextStyle(fontSize: 15, color: Colors.black)
                  //style: Theme.of(context).textTheme.caption,
                  );
            },
          ),*/
        ],
      ),
    );
  }

  Widget payment_Screen() {
    var count = appUser.carts.length;
    return ListView(
      children: [
        const SizedBox(height: 50.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Order Note",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: const TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Order Note',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16.0),
            Text("Payment Selection",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        RadioListTile(
            title: Text('Cash'),
            activeColor: Colors.amber,
            value: 1,
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title: Text('Credit Card'),
            activeColor: Colors.amber,
            value: 2,
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        const SizedBox(height: 50.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Sum of Products",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < count; i++)
                Text(
                    "${appUser.carts[i].product.name} \$${appUser.carts[i].product.price} x ${appUser.carts[i].numOfItem}",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Total Cost: \$${appUser.sumOfCart.value}",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Order order = Order(DateTime.now(), DateTime.now().toString(),appUser.uid, appUser.carts);
                appUser.carts = [];
                appUser.prevOrders.add(order);
                appUser.update();
                order.setId(saveOrder(order));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(widget.categories)));
              },
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.amber,
              child: const Text(
                'Confirm Payment',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
/*
Widget changeCardButton() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    width: double.infinity,
    child: RaisedButton(
      onPressed: () {
        
      },
      padding: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.amber,
      child: const Text(
        'Confirm Payment',
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
*/