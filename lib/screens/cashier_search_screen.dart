import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CashierSearchScreen extends StatefulWidget {
  const CashierSearchScreen({Key? key}) : super(key: key);

  @override
  _CashierSearchScreenState createState() => _CashierSearchScreenState();
}

class _CashierSearchScreenState extends State<CashierSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
      child: SearchField(
        hint: "Search Order",
        searchInputDecoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        maxSuggestionsInViewPort: 8,
        itemHeight: 50,
        searchStyle: TextStyle(
          fontSize: 18,
          color: Colors.black.withOpacity(0.8),
        ),
        suggestions: const [],
        onTap: (x) {
          print(x);
        },
      ),
    );
  }
}
