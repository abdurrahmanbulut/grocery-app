import 'package:flutter/material.dart';

class DetailedOrderPage extends StatefulWidget {
  const DetailedOrderPage({Key? key}) : super(key: key);

  @override
  State<DetailedOrderPage> createState() => _DetailedOrderPageState();
}

class _DetailedOrderPageState extends State<DetailedOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const Text('Order Details',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: ListView(children: [
            const SizedBox(height: 50.0),
            Row(
              children: const [
                SizedBox(width: 40.0),
                Text(
                  'Product',
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                ),
                SizedBox(width: 70.0),
                Text(
                  'Count',
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                ),
                SizedBox(width: 70.0),
                Text(
                  'Price',
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                ),
              ],
            ),
            Divider(
              height: 15,
              indent: 30,
              endIndent: 45,
              color: Colors.amber,
              thickness: 2,
            ),
            SizedBox(height: 50.0),
            Row(
              children: const [
                SizedBox(width: 40.0),
                Text(
                  'Total Price : 0.0\$',
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                ),
              ],
            ),
          ]),
        ));
  }
}
