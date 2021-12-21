import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';

class CartCard extends StatefulWidget {
  const CartCard(this.cartIndex,this.user,{
    Key? key,
  }) : super(key: key);

  final int cartIndex;
  final AppUser user;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(widget.user.carts[widget.cartIndex].product.image),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.carts[widget.cartIndex].product.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
                maxLines: 2,
              ),
              Text(
                widget.user.carts[widget.cartIndex].product.desc,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'OpenSans'),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${widget.user.carts[widget.cartIndex].product.price}  ",
                  style:
                      const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                  children: [
                    TextSpan(
                      text: " x${widget.user.carts[widget.cartIndex].numOfItem} =",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.pink),
                    ),
                    TextSpan(
                      text: " \$${(widget.user.carts[widget.cartIndex].product.price * widget.user.carts[widget.cartIndex].numOfItem)}",
                      style: const TextStyle(
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
                          widget.user.carts[widget.cartIndex].numOfItem++;
                          widget.user.sumCart();
                          widget.user.update();
                        });
                      }),
                    IconButton(
                      icon:  const Icon(Icons.remove,color: Colors.red,),
                      tooltip: 'Decrease amount',
                      onPressed: () {
                        setState(() {
                          if(widget.user.carts[widget.cartIndex].numOfItem >1) {
                            widget.user.carts[widget.cartIndex].numOfItem--;
                          }
                          widget.user.sumCart();
                          widget.user.update();
                        });
                      }),
                    ])
            ]);
  }
}
