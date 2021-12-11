import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:searchfield/searchfield.dart';

class SearchPage extends StatefulWidget {
  final AppUser user;

  SearchPage(this.user, {Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
      child: SearchField(
        hint: "Search Item",
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
        suggestions: const [
          'apple',
          'pepsi',
          'bread',
          'biskrem',
          'coffee',
          'tea',
          'sugar',
          'milk'
        ],
        onTap: (x) {
          print(x);
        },
      ),
    );
  }
}
