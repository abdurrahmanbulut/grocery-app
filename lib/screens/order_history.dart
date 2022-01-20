import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final List<Item> _data = generateItems(appUser.prevOrders.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderHistory(context),
    );
  }

  Widget orderHistory(context) {
    bool _isEmpty = true;
    if (appUser.prevOrders.length != 0) _isEmpty = false;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Geçmiş Siparişlerim",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: (_isEmpty)
                    ? emptyOrderHistory(context)
                    : OrderHistory(context))));
  }

  Widget OrderHistory(context) {
    var generalIndex;
    var currentIndex;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              trailing: const Icon(Icons.info),
              onTap: () {
                for (int i = 0; i < appUser.prevOrders.length; i++) {
                  if (item.headerValue == appUser.prevOrders[i].id)
                    currentIndex = i;
                }
                generalIndex = currentIndex;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistoryDetailed(
                          generalIndex: currentIndex,
                        )));
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget emptyOrderHistory(context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
              height: 200,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Henüz bir siparişin bulunmuyor!",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              )),
        ),
        const Center(
          child: Icon(
            Icons.shopping_basket,
            size: 100,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.value,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  TextButton value;
  bool isExpanded;
  int indexofItem = 0;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    String tempDate = appUser.prevOrders[index].time.toString();
    String date = tempDate.substring(0, 10);
    String time = tempDate.substring(11, 16);
    return Item(
      headerValue: '${appUser.prevOrders[index].id}',
      expandedValue:
          'Ad Soyad: ${appUser.name} \nTelefon: ${appUser.phoneNumber}\nEmail: ${appUser.email}\nTutar: ${appUser.sumOrder(index)} TL\nSaat: $time\nTarih: $date',
      value: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {},
        child: const Text('Enabled'),
      ),
    );
  });
}

class OrderHistoryDetailed extends StatelessWidget {
  final int generalIndex;
  OrderHistoryDetailed({required this.generalIndex});

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
      body: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              "Ürünler",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0;
              i < appUser.prevOrders[generalIndex].carts.length;
              i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(appUser
                        .prevOrders[generalIndex].carts[i].product.image),
                  ),
                  SizedBox(width: 10),
                  Text(
                    appUser.prevOrders[generalIndex].carts[i].product.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(" x ", style: TextStyle(fontSize: 20)),
                  Text(
                      appUser.prevOrders[generalIndex].carts[i].numOfItem
                          .toString(),
                      style: TextStyle(fontSize: 20)),
                  Text(" = ", style: TextStyle(fontSize: 20)),
                  Text(
                      (appUser.prevOrders[generalIndex].carts[i].numOfItem *
                              appUser.prevOrders[generalIndex].carts[i].product
                                  .price)
                          .toString(),
                      style: TextStyle(fontSize: 20)),
                  Text("TL", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text("Toplam Tutar = ${appUser.sumOrder(generalIndex)}TL",
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
              data: appUser.prevOrders[generalIndex].id,
              version: QrVersions.auto,
              size: 150.0,
            ),
          )
        ],
      ),
    );
  }
}