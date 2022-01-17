import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
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
                      OrderHistoryDetailed(order: widget.orders[index])));
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

/*
List<Item> generateItems(
    int numberOfItems, AsyncSnapshot<List<Order>> AllOrders) {
  return List<Item>.generate(numberOfItems, (index) {
    return Item(
      headerValue: '${AllOrders.data![index].id as String}',
      expandedValue: '${AllOrders.data![index].buyerId}',
      value: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {},
        child: const Text('Enabled'),
      ),
    );
  });
}*/
/*
AppUser GetUser(String BuyerID){
AppUser buyerUser;
List<AppUser> users = await getAllUsers();

}*/

class OrderHistoryDetailed extends StatelessWidget {
  Order order;
  OrderHistoryDetailed({required this.order});

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
                  '${order.carts[index].product.name}  x  ${order.carts[index].numOfItem}  =  $itemprice\$'),
              leading: CircleAvatar(
                backgroundImage: AssetImage(order.carts[index].product.image),
              ),
            );
          }),
    );
  }
}

/*
              var now = new DateTime.now();
              var formatter = new DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              String tempDate = AllOrders.data![0].id.toString();
              String date = tempDate.substring(0, 10);*/

/*
SingleChildScrollView(
        child: FutureBuilder(
            future: generateOrderCode(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Order>> AllOrders) {
              List<Item> _data =
                  generateItems(AllOrders.data!.length as int, AllOrders);
              int generalIndex = 0;
              var now = new DateTime.now();
              var formatter = new DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              String tempDate = AllOrders.data![0].id.toString() as String;
              String date = tempDate.substring(0, 10);
              int removeToWhere = 0;
              for (int i = 0; i < AllOrders.data!.length as bool; i++) {
                tempDate = AllOrders.data![i].id.toString() as String;
                date = tempDate.substring(0, 10);
                if (date != formattedDate) removeToWhere++;
              }
              _data.removeRange(0, removeToWhere);
              return ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    print('${_data[index].isExpanded} bbbbbbbbb');
                    _data[index].isExpanded = !isExpanded;
                    generalIndex = index;
                    print('${_data[index].isExpanded} aaaaaa');
                  });
                },
                children: _data.map<ExpansionPanel>((Item item) {
                  print('${_data[0].isExpanded} cccccccc');
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrderHistoryDetailed(
                                    order: AllOrders.data![generalIndex],
                                  )));
                        }),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              );
            }));
            */