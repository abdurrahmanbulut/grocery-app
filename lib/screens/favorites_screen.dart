import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoritesScreen(context),
    );
  }
}

Widget favoritesScreen(context) {
  return Scaffold(
      appBar: AppBar(
        title: Row(children: const [
          Center(
            child: Text(
              "               My Favorites                 ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          )
        ]),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 200,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "You haven't add anything yet!",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              )),
          const Icon(
            Icons.favorite,
            size: 100,
            color: Colors.grey,
          )
        ],
      ));
}
