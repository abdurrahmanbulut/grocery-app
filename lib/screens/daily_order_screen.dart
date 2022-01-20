import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/orderstatus_screen.dart';
import 'package:grocery_app/services/database.dart';

class DailyOrderScreen extends StatefulWidget {
  const DailyOrderScreen({Key? key}) : super(key: key);

  @override
  _DailyOrderScreenState createState() => _DailyOrderScreenState();
}

class _DailyOrderScreenState extends State<DailyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    List<Order> dailyOrders = appUser.getDailyOrders();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('GROCERY APP',
            style: TextStyle(
                color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: dailyOrders.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      OrderScreen(order: dailyOrders[index])));
            },
            child: ListTile(
              title: Text(dailyOrders[index].id),
              subtitle: Text(dailyOrders[index].time.toString()),
            ),
          );
        },
      ),
    );
  }
}
