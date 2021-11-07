import 'package:flutter/material.dart';
import 'package:grocery_app/screens/contact_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: accountView(context),
    );
  }
}

Widget accountView(context) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: ListView(
      children: [
        Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.amber,
            ),
            TextButton(
              child: const Text(
                  "Profile                                                 ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber,
            )
          ],
        ),
        const Divider(
          height: 15,
          thickness: 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.amber,
            ),
            TextButton(
              child: const Text(
                  "Previous Orders                                ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              onPressed: () {},
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber,
            )
          ],
        ),
        const Divider(
          height: 15,
          thickness: 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.amber,
            ),
            TextButton(
              child: const Text(
                  "Favorites                                            ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              onPressed: () {},
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber,
            )
          ],
        ),
        const Divider(
          height: 15,
          thickness: 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.credit_card,
              color: Colors.amber,
            ),
            TextButton(
              child: const Text(
                  "Cards                                                  ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              onPressed: () {},
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber,
            )
          ],
        ),
        const Divider(
          height: 15,
          thickness: 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.contacts,
              color: Colors.amber,
            ),
            TextButton(
              child: const Text(
                  "Contact                                              ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Contact()));
              },
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber,
            )
          ],
        ),
        const Divider(
          height: 15,
          thickness: 2,
        ),
        TextButton(
          child: const Text("Sing Out",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        ),
      ],
    ),
  );
}
