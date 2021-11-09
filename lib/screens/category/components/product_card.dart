import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function press;

  const ProductCard({Key? key,required this.product,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 100,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(product.image),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            product.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            product.price.toString() + " TL",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}