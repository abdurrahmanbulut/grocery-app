import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Severus grocery'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Main screen'),
      ),
      floatingActionButton:
          FloatingActionButton(backgroundColor: Colors.white, onPressed: () {}),
    );
  }
}
