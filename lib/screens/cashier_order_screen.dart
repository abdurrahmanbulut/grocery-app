import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cashier_detailed_order_screen.dart';
import 'package:grocery_app/services/database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CashierOrderScreen extends StatefulWidget {
  final List<Order> orders;

  const CashierOrderScreen(this.orders, {Key? key}) : super(key: key);

  @override
  State<CashierOrderScreen> createState() => _CashierOrderScreenState();
}

class _CashierOrderScreenState extends State<CashierOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailedOrderPage(order: widget.orders[index])));
            },
            child: ListTile(
              title: Text(widget.orders[index].id),
              subtitle: Text(widget.orders[index].time.toString()),
            ),
          ),
        );
      },
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child:
                SpinKitFadingCube(color: Colors.lightGreen[100], size: 50.0)));
  }
}

class OrderHistoryDetailed extends StatelessWidget {
  Order order;
  OrderHistoryDetailed({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sipariş Detayı",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
          itemCount: order.carts.length,
          itemBuilder: (context, index) {
            var itemprice =
                order.carts[index].numOfItem * order.carts[index].product.price;
            return ListTile(
              minVerticalPadding: 30.0,
              minLeadingWidth: 50.0,
              contentPadding: EdgeInsets.fromLTRB(30, 5, 0, 5),
              visualDensity: VisualDensity.comfortable,
              title: Text(
                  '${order.carts[index].product.name}  x  ${order.carts[index].numOfItem}  =  $itemprice TL'),
              leading: CircleAvatar(
                backgroundImage: AssetImage(order.carts[index].product.image),
              ),
            );
          }),
    );
  }
}
