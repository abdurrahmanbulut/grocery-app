import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex=0;
  PageController pageController=PageController();
  void onTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: Text('GROCERY APP',style: TextStyle(color:Colors.black,fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(color:Colors.white,),
          Container(color:Colors.black),
          Container(color:Colors.red),
          Container(color:Colors.orange),
          Container(color:Colors.blue),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label:'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.campaign), label:'Campaigns'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label:'Account'),
      ],
        currentIndex: _selectedIndex,
        selectedItemColor:Colors.amber,unselectedItemColor: Colors.black ,
        onTap:  onTapped,),
    );

  }
}
