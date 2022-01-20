import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'category/components/product_card.dart';

class SearchPage extends StatefulWidget {
  final List<CategoryProduct> categories;

  const SearchPage(this.categories, {Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> filteredProducts = [];
  List<String> suggestions = ['cola','coffee','snack'];
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
    filteredProducts = getFilteredProducts(widget.categories, keyword.value);
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
              hintText: 'Ürün ara',
              hintStyle: kLabelStyle,
            ),
            onChanged: (value) {
              setState(() {
                keyword.value = value;
                filteredProducts =
                      getFilteredProducts(widget.categories, keyword.value);
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
  Widget productListCreate(){
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
              itemBuilder: (context, index) => ProductCard(
                product: filteredProducts[index],
                press: () {}
              ))),
    );
  }
}
