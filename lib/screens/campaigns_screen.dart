import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/campaign/campaign_class.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/screens/category/components/product_card.dart';

class Campaigns extends StatefulWidget {
  final List<CategoryProduct> categories;
  const Campaigns(this.categories, {Key? key}) : super(key: key);

  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: ListView(
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        children: [
          buildCampaignContainer(0),
          buildCampaignContainer(1),
          buildCampaignContainer(2),
          buildCampaignContainer(3),
          buildCampaignContainer(4),
          buildCampaignContainer(5),
        ],
      ),
    );
  }

  Container buildCampaignContainer(
    int numberOfCampaing,
  ) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white38,
          /*boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: Colors.grey.withOpacity(0.15),
              )
            ]*/
        ),
        child: Container(
          padding: EdgeInsets.all(8), // Border width
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton.icon(
            icon: Column(
              children: [
                Image.asset(campaigns[numberOfCampaing].image,
                    height: 250, width: 250, fit: BoxFit.cover),
                Text(
                  "\nDetaylar için tıklayınız.",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                
              ],
            ),
            label: Text(" "),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondRoute(
                        categories: widget.categories, data: numberOfCampaing)),
              );
            },
          ),
        ));
  }
}

class SecondRoute extends StatefulWidget {
  final int data;
  final List<CategoryProduct> categories;
  SecondRoute({required this.categories, required this.data});

  @override
  State<SecondRoute> createState() => _SecondRouteState(data: data);
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  final int data;

  _SecondRouteState({required this.data});
  List<Product> filteredProducts = [];
  var keyword = ValueNotifier<String>('');

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Campaign",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: printingCampaign(data));
  }

  Container printingCampaign(int numberOfCampaing) {
    print(campaigns[numberOfCampaing].product);
    keyword.value = campaigns[numberOfCampaing].product;

    filteredProducts = getFilteredProducts(widget.categories, keyword.value);
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              width: 20,
              height: 20,
            ),
            Center(
                child: Image.asset(
              campaigns[numberOfCampaing].image,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            )),
            const SizedBox(
              width: 25,
              height: 25,
            ),
            Text(campaigns[numberOfCampaing].title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text(
              campaigns[numberOfCampaing].description,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: Colors.grey.shade100,
              height: 15,
              thickness: 2,
            ),
            ValueListenableBuilder(
              valueListenable: keyword,
              builder: (context, value, widget) {
                return productListCreate();
              },
            ),
          ],
        ));
  }

  Widget productListCreate() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                childAspectRatio: 0.75,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ProductCard(product: filteredProducts[index], press: () {}))),
    );
  }
}
