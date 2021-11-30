import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderHistory(context),
    );
  }
}

Widget orderHistory(context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Previous Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 200,
              child: TextButton(
                onPressed: () {},
                child: const Text("You haven't order anything yet!",style: TextStyle(color: Colors.grey,fontSize: 20),),
              )),
          const Icon(
            Icons.shopping_basket,
            size: 100,
            color: Colors.grey,
          )    
        ],
      ));
}
