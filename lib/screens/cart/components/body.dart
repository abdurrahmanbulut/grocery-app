import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/model/user.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final AppUser user;
  const Body(this.user,{Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<AppUser> valueNotifier = ValueNotifier<AppUser>(widget.user);
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, widget) {
        return createBody(valueNotifier);
      },
    );
  }
  Widget createBody(ValueNotifier<AppUser> valueNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: widget.user.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.user.carts[index].product.name.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                widget.user.carts.removeAt(index);
                widget.user.sumCart();
                widget.user.update();
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context, value, widget) {
                return CartCard(index,valueNotifier.value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
