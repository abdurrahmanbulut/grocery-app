import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_app/model/data_model.dart';

import '../services/database.dart';


class AppUser{
  DatabaseReference dataId = databaseReference;
  String uid;
  String name;
  String image;
  String email;
  String password;
  String phoneNumber;
  Type type;
  List<ShoppingCard> cards = [];
  List<Order> prevOrders = [];
  List<Cart> carts = [];


  AppUser(this.uid, this.name, this.image, this.email,
      this.password, this.phoneNumber, this.type);

  Map<String, dynamic> toJson() {
    List<Map> cards =  this.cards.map((i) => i.toJson()).toList();
    List<Map> prevOrders =  this.prevOrders.map((i) => i.toJson()).toList();
    List<Map> carts =  this.carts.map((i) => i.toJson()).toList();
    return {
      'uid': uid,
      'name':name,
      'image':image,
      'email':email,
      'password':password,
      'phoneNumber':phoneNumber,
      'type': (type == Type.customer)? 0 : 1,
      'cards':cards,
      'prevOrders':prevOrders,
      'carts':carts
    };
  }

  void update() {
    updateUser(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }

  @override
  bool operator ==(Object other) {
    return ((other as AppUser).email == email);
  }

  @override
  int get hashCode => email.hashCode;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    json["uid"],
    json["name"],
    json["image"],
    json["email"],
    json["password"],
    json["phoneNumber"],
    intToType(json["type"]),
  );

}

enum Type {
  customer,
  cashier,
  none
}

class ShoppingCard{
  String number;
  int cvs;
  int year;
  int month;

  ShoppingCard(this.number,this.cvs,this.year,this.month);

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'cvs':cvs,
      'year':year,
      'month':month
    };
  }

  factory ShoppingCard.fromJson(Map<String, dynamic> json) => ShoppingCard(
    json["number"],
    json["cvs"],
    json["year"],
    json["month"]
  );
}

class Order{
  DateTime time;
  String id;
  List<Product> products = [];

  Order(this.time, this.id,this.products);

  Map<String, dynamic> toJson() {
    List<Map> products =  this.products.map((i) => i.toJson()).toList();
    return {
      'time': time,
      'id':id,
      'products':products
    };
  }
  factory Order.fromJson(Map<String, dynamic> json) => Order(
      json["time"],
      json["id"],
      List<Product>.from(json["products"].map((i) => Product.fromJson(i))),
  );
}

AppUser createUser(record) {
  Map<String, dynamic> attributes = {
    'uid': '',
    'name':'',
    'image':'',
    'email':'',
    'password':'',
    'phoneNumber':'',
    'type':'',
    'cards':[],
    'prevOrders':[],
    'carts':[]
  };

  record.forEach((key, value) => {attributes[key] = value});

  AppUser user = AppUser(attributes['uid'], attributes['name'],
      attributes['image'],attributes['email'],
      attributes['password'],attributes['phoneNumber'],intToType(attributes['type']));
  String jsonCard = jsonEncode(attributes['cards']);
  String jsonOrder = jsonEncode(attributes['prevOrders']);
  String jsonCart = jsonEncode(attributes['carts']);
  var cardList = json.decode(jsonCard) as List;
  var orderList = json.decode(jsonOrder) as List;
  var cartList = json.decode(jsonCart) as List;
  user.cards = cardList.map((i)=>ShoppingCard.fromJson(i)).toList();
  user.prevOrders = orderList.map((i)=>Order.fromJson(i)).toList();
  user.carts = cartList.map((i)=>Cart.fromJson(i)).toList();
  return user;
}

Type intToType(int type) {
  if(type == 0){
    return Type.customer;
  }
  else if(type == 1){
    return Type.cashier;
  }
  else {
    return Type.none;
  }
}