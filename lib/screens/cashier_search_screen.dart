import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cashier_detailed_order_screen.dart';
import 'package:grocery_app/screens/cashier_order_screen.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'category/components/product_card.dart';

class CashierSearchPage extends StatefulWidget {
  final List<Order> orders;

  const CashierSearchPage(this.orders, {Key? key}) : super(key: key);

  @override
  _CashierSearchPageState createState() => _CashierSearchPageState();
}

class _CashierSearchPageState extends State<CashierSearchPage> {
  List<Order> filteredOrders = [];

  var keyword = ValueNotifier<String>('');
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredOrders = getFilteredOrders(keyword.value, widget.orders);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          width: 400.0,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            controller: _searchController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.amber,
              ),
              hintText: 'Sipariş Ara',
              hintStyle: kLabelStyle,
            ),
            onChanged: (value) {
              setState(() {
                keyword.value = value;
                filteredOrders =
                    getFilteredOrders(keyword.value, widget.orders);
              });
            },
          ),
        ),
        const SizedBox(height: 20.0),
        ValueListenableBuilder(
          valueListenable: keyword,
          builder: (context, value, widget) {
            return productListCreate();
          },
        ),
      ],
    );
  }

  Widget productListCreate() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailedOrderPage(order: filteredOrders[index])));
                },
                child: ListTile(
                  title: Text(filteredOrders[index].id),
                  subtitle: Text(filteredOrders[index].time.toString()),
                ),
              );
            },
          )),
    );
  }
}
