import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Grocery Name",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("Grocery Name",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Text("Owner", style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("The Severus",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Text("Telephone Number",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("05999999",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Text("Adress", style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("İstanbul",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Text("E-Mail", style: TextStyle(fontSize: 15, color: Colors.grey)),
            Text("theseverus@gmail.com",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Divider(
              height: 15,
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
