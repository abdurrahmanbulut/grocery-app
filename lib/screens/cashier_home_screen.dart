import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/cashier_order_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/search_screen.dart';
import 'package:grocery_app/screens/cashier_qr_scan_screen.dart';

class CashierHomeScreen extends StatefulWidget {
  final AppUser user;
  final List<CategoryProduct> categories;
  const CashierHomeScreen(this.user, this.categories, {Key? key})
      : super(key: key);

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
    @override
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QRScreenWidget()));
              },
              icon: Icon(Icons.qr_code_2_outlined),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginScreen(widget.categories)));
                },
              )
            ],
            elevation: 0,
            backgroundColor: Colors.amber,
            title: const Text('GROCERY APP',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
            centerTitle: true,
          ),
          body: PageView(
            controller: pageController,
            children: [
              Container(child: CashierOrderScreen()),
              Container(child: SearchPage(widget.user, widget.categories)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.black,
            onTap: onTapped,
          ),
        ));
  }
}
