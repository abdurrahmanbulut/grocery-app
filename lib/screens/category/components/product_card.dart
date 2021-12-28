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
  ValueNotifier<int> valueNotifier = ValueNotifier<int>(-1);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, widget) {
        return card();
      },
    );
  }

  Widget card() {
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
                      valueNotifier.value = widget.user.indexCart(widget.product);
                    }
                    if (valueNotifier.value != -1) {
                      if(widget.user.carts[valueNotifier.value].numOfItem >1) {
                        widget.user.carts[valueNotifier.value].numOfItem--;
                      }
                      else if(widget.user.carts[valueNotifier.value].numOfItem == 1){
                        widget.user.carts.removeAt(valueNotifier.value);
                        valueNotifier.value = -1;
                      }
                    }
                    widget.user.sumCart();
                    widget.user.update();
                  });
                }),
            Text((valueNotifier.value == -1)? '0' : widget.user.carts[valueNotifier.value].numOfItem.toString(),
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
                    if(widget.user.indexCart(widget.product) == -1) {
                      valueNotifier.value = -1;
                    }
                    if(widget.user.cartContains(widget.product)) {
                      valueNotifier.value = widget.user.indexCart(widget.product);
                    }
                    if (valueNotifier.value == -1 && widget.product.count>1) {
                      widget.user.carts.add(Cart(product: widget.product, numOfItem: 1));
                      valueNotifier.value = widget.user.indexCart(widget.product);
                    }
                    else if(widget.product.count>widget.user.carts[valueNotifier.value].numOfItem+1){
                      widget.user.carts[valueNotifier.value].numOfItem++;
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
      valueNotifier.value = widget.user.indexCart(widget.product);
    }
    else {
      valueNotifier.value = -1;
    }
  }
}
