import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';

class ProductCard extends StatefulWidget {
  final AppUser user;
  final Product product;
  final Function press;

  const ProductCard({Key? key, required this.product, required this.press,required this.user})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      (widget.product.count != 0)?
        Expanded(
          child:  Container(
            padding: const EdgeInsets.all(1.5),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(widget.product.image)
          ),
        ) :
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(1.5),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            widget.product.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.product.price.toString() + " TL",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.remove),
                iconSize: 20,
                color: Colors.black,
                tooltip: 'Decrease amount',
                onPressed: () {
                  setState(() {
                    if(widget.user.cartContains(widget.product)) {
                      index = widget.user.indexCart(widget.product);
                    }
                    if (index != -1) {
                      if(widget.user.carts[index].numOfItem >1) {
                        widget.user.carts[index].numOfItem--;
                      }
                      else if(widget.user.carts[index].numOfItem == 1){
                        widget.user.carts.removeAt(index);
                      }
                    }
                    widget.user.sumCart();
                    widget.user.update();
                  });
                }),
            Text((index == -1)? '0' : widget.user.carts[index].numOfItem.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
            IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.add),
                tooltip: 'Increase amount',
                iconSize: 20,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    if(widget.user.cartContains(widget.product)) {
                      index = widget.user.indexCart(widget.product);
                    }
                    if (index == -1 && widget.product.count>1) {
                      widget.user.carts.add(Cart(product: widget.product, numOfItem: 1));
                    }
                    else if(widget.product.count>widget.user.carts[index].numOfItem+1){
                      widget.user.carts[index].numOfItem++;
                    }
                    widget.user.sumCart();
                    widget.user.update();
                  });
                }),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.user.cartContains(widget.product)) {
      index = widget.user.indexCart(widget.product);
    }
  }
}
