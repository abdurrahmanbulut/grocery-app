import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    double productSum = 0;
    productSum = cart.product.price * cart.numOfItem;
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
              child: Image.asset(cart.product.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.name,
              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
              maxLines: 2,
            ),
            Text(
              cart.product.desc,
              style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans'),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}  ",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                children: [
                  TextSpan(
                    text: " x${cart.numOfItem} =",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.pink),
                  ),
                  TextSpan(
                    text: " \$${productSum}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
