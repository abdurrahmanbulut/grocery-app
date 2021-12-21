import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/cart/components/cart_card.dart';

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
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(1.5),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(widget.product.image),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            widget.product.name,
            style: TextStyle(color: Colors.black),
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
                    if (index == -1) {
                      widget.user.carts.add(Cart(product: widget.product, numOfItem: 1));
                    }
                    else {
                      widget.user.carts[index].numOfItem++;
                    }
                    widget.user.sumCart();
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
