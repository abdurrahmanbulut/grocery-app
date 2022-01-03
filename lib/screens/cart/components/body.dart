import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/services/database.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<AppUser> valueNotifier = ValueNotifier<AppUser>(appUser);
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
        itemCount: appUser.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(appUser.carts[index].product.name.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                appUser.carts.removeAt(index);
                appUser.sumCart();
                appUser.update();
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
