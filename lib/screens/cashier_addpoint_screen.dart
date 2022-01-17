import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/model/wallet_transaction.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/constants.dart';
import 'category/components/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPointPage extends StatefulWidget {
  const AddPointPage({Key? key}) : super(key: key);

  @override
  _AddPointPageState createState() => _AddPointPageState();
}

class _AddPointPageState extends State<AddPointPage> {
  List<AppUser> filteredUsers = [];
  var keyword = ValueNotifier<String>('');
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    filteredUsers = await getFilteredUsers(keyword.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          width: 400.0,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            controller: _searchController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 13.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.amber,
              ),
              hintText: 'Search User',
              hintStyle: kLabelStyle,
            ),
            onChanged: (value) {
              setState(() async {
                keyword.value = value;
                filteredUsers = await getFilteredUsers(keyword.value);
              });
            },
          ),
        ),
        const SizedBox(height: 20.0),
        ValueListenableBuilder(
          valueListenable: keyword,
          builder: (context, value, widget) {
            return productListCreate();
          },
        ),
      ],
    );
  }

  Widget productListCreate() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: ListTile(
                title: Text(filteredUsers[index].email),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPointToUser(
                        generalIndex: index, user: filteredUsers[index])));
              },
            );
          },
        ),
      ),
    );
  }
}

class AddPointToUser extends StatefulWidget {
  final int generalIndex;
  final AppUser user;
  AddPointToUser({required this.generalIndex, required this.user});

  @override
  State<AddPointToUser> createState() => _AddPointToUserState();
}

class _AddPointToUserState extends State<AddPointToUser> {
  double AmountWillBeAdded = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Add Balance',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              width: (MediaQuery.of(context).size.width / 1.25),
              height: 100,
              alignment: Alignment.center,
              child: Text(
                "${widget.user.email}'s Balance\n\n${widget.user.wallet}\$",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: (MediaQuery.of(context).size.width / 1.25),
            child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Please enter amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17)),
                ),
                onChanged: (value) {
                  setState(() {
                    AmountWillBeAdded = double.parse(value);
                  });
                }),
          ),
          SizedBox(height: 20),
          Container(
            child: RaisedButton(
              onPressed: () {
                final auth = FirebaseAuth.instance;
                //     const user = auth.currentUser.uid
                WalletTransaction walletTransaction = WalletTransaction(
                    DateTime.now(),
                    AmountWillBeAdded,
                    widget.user.uid,
                    auth.currentUser!.uid);
                print(widget.user.email);
                print(auth.currentUser!.email);
                widget.user.addWallet(AmountWillBeAdded);
                widget.user.update();
                showAlertDialog(context, AmountWillBeAdded, widget.user);
              },
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0),
              ),
              color: Colors.amber,
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, double value, AppUser user) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text('Transaction Successful'),
    content: Text("$value\$ added to ${user.email}'s balance!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
