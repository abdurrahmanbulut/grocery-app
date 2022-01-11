import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/database.dart';

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
            "My Previous Orders",
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
                  "You haven't order anything yet!",
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
          'Name: ${appUser.name} \nPhone: ${appUser.phoneNumber}\nEmail: ${appUser.email}\nPrice: ${appUser.sumOrder(index)}\$\nTime: $time\nDate: $date',
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
          "Order Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
          itemCount: appUser.prevOrders[generalIndex].carts.length,
          itemBuilder: (context, index) {
            var itemprice =
                appUser.prevOrders[generalIndex].carts[index].numOfItem *
                    appUser.prevOrders[generalIndex].carts[index].product.price;
            return ListTile(
              minVerticalPadding: 30.0,
              minLeadingWidth: 50.0,
              contentPadding: EdgeInsets.fromLTRB(30, 5, 0, 5),
              visualDensity: VisualDensity.comfortable,
              title: Text(
                  '${appUser.prevOrders[generalIndex].carts[index].product.name}  x  ${appUser.prevOrders[generalIndex].carts[index].numOfItem}  =  $itemprice\$'),
              leading: CircleAvatar(
                backgroundImage: AssetImage(appUser
                    .prevOrders[generalIndex].carts[index].product.image),
              ),
            );
          }),
    );
  }
}
/*
ListView(
        children: [
          SizedBox(height: 50),
          for (int i = 0;
              i < appUser.prevOrders[generalIndex].carts.length;
              i++)
            Text(appUser.prevOrders[generalIndex].carts[i].product.name)
        ],
      ),*/