import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailedOrderPage extends StatefulWidget {
  Order order;
  DetailedOrderPage({required this.order});

  @override
  State<DetailedOrderPage> createState() => _DetailedOrderPageState();
}

class _DetailedOrderPageState extends State<DetailedOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              "Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0; i < widget.order.carts.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage(widget.order.carts[i].product.image),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.order.carts[i].product.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(" x ", style: TextStyle(fontSize: 20)),
                  Text(widget.order.carts[i].numOfItem.toString(),
                      style: TextStyle(fontSize: 20)),
                  Text(" = ", style: TextStyle(fontSize: 20)),
                  Text(
                      (widget.order.carts[i].numOfItem *
                              widget.order.carts[i].product.price)
                          .toString(),
                      style: TextStyle(fontSize: 20)),
                  Text("\$", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text("Total Price = ${widget.order.sumOrder2()}\$",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
          Divider(
            height: 2,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          SizedBox(height: 40),
          Center(
            child: Text(
              "QR Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            child: QrImage(
              data: widget.order.id,
              version: QrVersions.auto,
              size: 150.0,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () {
                    widget.order.status = OrderStatus.prepared;
                    widget.order.update();
                    print(widget.order.status.toString());
                  },
                  child: Container(
                    height: 50,
                    width: 85,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text('Set Prepared'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: InkWell(
                  onTap: () {
                    widget.order.status = OrderStatus.taken;
                    widget.order.update();
                    print(widget.order.status.toString());
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: 85,
                    color: Colors.green,
                    child: Center(
                      child: Text('Set Ready'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () {
                    widget.order.status = OrderStatus.canceled;
                    widget.order.update();
                    print(widget.order.status.toString());
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: 85,
                    color: Colors.red,
                    child: Center(
                      child: Text('Set Canceled'),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
