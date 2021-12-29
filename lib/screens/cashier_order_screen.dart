import 'package:grocery_app/screens/cashier_detailed_order_screen.dart';
import 'package:flutter/material.dart';

class CashierOrderScreen extends StatefulWidget {
  const CashierOrderScreen({Key? key}) : super(key: key);

  @override
  State<CashierOrderScreen> createState() => _CashierOrderScreenState();
}

class _CashierOrderScreenState extends State<CashierOrderScreen> {
  final List<Item> _data = generateItems(20);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DetailedOrderPage()));
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
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
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'ORDER NUMBER $index',
      expandedValue:
          'Name: Abdullah Yigit \nPhone: 5xxxxxxxxx\nPrice: 150.00 TL\nTime: 15:30\nDate: 02/12/21\n',
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
