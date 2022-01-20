import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/services/database.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function press;

  const ProductCard({Key? key, required this.product, required this.press})
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
    valueNotifier.value = appUser.indexCart(widget.product);
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
      (widget.product.count != 0)?
      SizedBox(
        child:  Container(
            padding: const EdgeInsets.only(left: 0.5),
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(widget.product.image, width: 80,)
        ),
      ) :
      Container(
              padding: const EdgeInsets.only(left: 0.5),
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(widget.product.image),
                  fit: BoxFit.scaleDown,
                ),
              ),
        child: Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
                color: Colors.white.withOpacity(0.5)
            ),
          ),
              ),
            ),
      Padding(
        padding:  EdgeInsets.only(
            left: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0,
            right: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0
        ),
        child: SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 4),
            child: Text(
                widget.product.name,
                style: const TextStyle(color: Colors.black, fontSize: 11)
                ),
              ),
            ),
          ),

      (widget.product.discount == 0)? Padding(
        padding: EdgeInsets.only(
            left: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0,
            right: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              widget.product.price.toString() + " TL",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
      ):
      Padding(
        padding: EdgeInsets.only(
          left: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0,
          right: (widget.product.name.length<35)? 35-widget.product.name.length.toDouble() : 0,
        ),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.product.price.toString() + "   ",
                style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold
                ),
              ),
              TextSpan(
                text: (widget.product.getDiscountedPrice()).toString() + " TL",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.remove),
                iconSize: 15,
                color: Colors.black,
                tooltip: 'Decrease amount',
                onPressed: () {
                  setState(() {
                    if(appUser.cartContains(widget.product)) {
                      valueNotifier.value = appUser.indexCart(widget.product);
                    }
                    if (valueNotifier.value != -1) {
                      if(appUser.carts[valueNotifier.value].numOfItem >1) {
                        appUser.carts[valueNotifier.value].numOfItem--;
                      }
                      else if(appUser.carts[valueNotifier.value].numOfItem == 1){
                        appUser.carts.removeAt(valueNotifier.value);
                        valueNotifier.value = -1;
                      }
                    }
                    appUser.sumCart();
                    appUser.update();
                  });
                }),
            Text((valueNotifier.value != -1 && appUser.cartContains(widget.product))? appUser.carts[valueNotifier.value].numOfItem.toString() : '0',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
            IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.add),
                tooltip: 'Increase amount',
                iconSize: 15,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    if(appUser.indexCart(widget.product) == -1) {
                      valueNotifier.value = -1;
                    }
                    if(appUser.cartContains(widget.product)) {
                      valueNotifier.value = appUser.indexCart(widget.product);
                    }
                    if (valueNotifier.value == -1 && widget.product.count>1) {
                      appUser.carts.add(Cart(product: widget.product, numOfItem: 1));
                      valueNotifier.value = appUser.indexCart(widget.product);
                    }
                    else if(widget.product.count>appUser.carts[valueNotifier.value].numOfItem){
                      appUser.carts[valueNotifier.value].numOfItem++;
                    }
                    appUser.sumCart();
                    appUser.update();
                  });
                }),
          ],
        ),
          ),
          ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if(appUser.cartContains(widget.product)) {
      valueNotifier.value = appUser.indexCart(widget.product);
    }
    else {
      valueNotifier.value = -1;
    }
  }
}
