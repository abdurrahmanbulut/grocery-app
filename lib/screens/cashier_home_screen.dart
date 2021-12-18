import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cashier_order_screen.dart';
import 'package:grocery_app/screens/cashier_search_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';

class CashierHomeScreen extends StatefulWidget {
  final AppUser user;
  final List<CategoryProduct> categories;
  const CashierHomeScreen(this.user,this.categories,{Key? key}) : super(key: key);

  @override
  _CashierHomeScreenState createState() => _CashierHomeScreenState();
}

class _CashierHomeScreenState extends State<CashierHomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen(widget.categories)));
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('GROCERY APP',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(child: CashierOrderScreen()),
          Container(child: CashierSearchScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
