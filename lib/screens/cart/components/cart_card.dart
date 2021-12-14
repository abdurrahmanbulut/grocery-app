import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';

class CartCard extends StatefulWidget {
  CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  Cart cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

double print_func(double sum) {
  TextSpan(text: "\$$sum", style: TextStyle(fontSize: 22, color: Colors.black));

  return sum;
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    double productSum = 0;
    productSum = widget.cart.product.price * widget.cart.numOfItem;
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(widget.cart.product.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.product.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
                maxLines: 2,
              ),
              Text(
                widget.cart.product.desc,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'OpenSans'),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${widget.cart.product.price}  ",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                  children: [
                    TextSpan(
                      text: " x${widget.cart.numOfItem} =",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.pink),
                    ),
                    TextSpan(
                      text: " \$${productSum}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: 120
                    ),
                    ),])),
                  
                  ],
                ),
              ),  Column(children: [
                    IconButton(
                      icon:  const Icon(Icons.add,color: Colors.black,),
                      tooltip: 'Increase amount',
                      onPressed: () {
                        setState(() {
                          widget.cart.numOfItem++;
                        });
                      }),
                    IconButton(
                      icon:  const Icon(Icons.remove,color: Colors.red,),
                      tooltip: 'Decrease amount',
                      onPressed: () {
                        setState(() {
                          if (widget.cart.numOfItem != 0) {
                            widget.cart.numOfItem--;
                          }
                        });
                      }),
                    ])
            ]);
  }
}
