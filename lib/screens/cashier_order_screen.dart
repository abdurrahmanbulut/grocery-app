import 'package:grocery_app/screens/cashier_detailed_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:intl/intl.dart';

class CashierOrderScreen extends StatefulWidget {
  const CashierOrderScreen({Key? key}) : super(key: key);

  @override
  State<CashierOrderScreen> createState() => _CashierOrderScreenState();
}

class _CashierOrderScreenState extends State<CashierOrderScreen> {
  List<Order> AllOrders = [];

  bool _isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder(
            future: generateOrderCode(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Order>> AllOrders) {
              List<Item> _data =
                  generateItems(AllOrders.data!.length as int, AllOrders);
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
                        onTap: () {}),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              );
            }));
  }

  Future<List<Order>> generateOrderCode() async {
    List<Order> allOrders = await getAllOrders();
    return allOrders;
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

List<Item> generateItems(
    int numberOfItems, AsyncSnapshot<List<Order>> AllOrders) {
  return List<Item>.generate(numberOfItems, (index) {
    return Item(
      headerValue: '${AllOrders.data![index].id as String}',
      expandedValue: 'Name:',
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

/*
              var now = new DateTime.now();
              var formatter = new DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              String tempDate = AllOrders.data![0].id.toString();
              String date = tempDate.substring(0, 10);*/