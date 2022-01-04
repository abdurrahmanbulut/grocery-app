import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/notification.dart';

import '../services/database.dart';

class AppUser {
  DatabaseReference dataId = databaseReference;
  String uid;
  String name;
  String image;
  String email;
  String password;
  String phoneNumber;
  Type type;
  double wallet;
  ValueNotifier<double> sumOfCart = ValueNotifier<double>(0);
  List<ShoppingCard> cards = [];
  List<Order> prevOrders = [];
  List<Cart> carts = [];
  List<UserNotification> notifications = [];

  AppUser(this.uid, this.name, this.image, this.email, this.password,
      this.phoneNumber, this.type,this.wallet);

  Map<String, dynamic> toJson() {
    List<Map> cards = this.cards.map((i) => i.toJson()).toList();
    List<Map> prevOrders = this.prevOrders.map((i) => i.toJson()).toList();
    List<Map> carts = this.carts.map((i) => i.toJson()).toList();
    List<Map> notifications =
        this.notifications.map((i) => i.toJson()).toList();
    return {
      'uid': uid,
      'name': name,
      'image': image,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'type': (type == Type.customer) ? 0 : 1,
      'wallet': wallet,
      'cards': cards,
      'prevOrders': prevOrders,
      'carts': carts,
      'notifications': notifications
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
        json["wallet"]
      );

  bool cartContains(Product product) {
    if (carts.isEmpty) {
      return false;
    }
    int index = -1;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].product == product) {
        index = i;
      }
    }
    if (index != -1) {
      return true;
    }
    return false;
  }

  int indexCart(Product product) {
    int index = -1;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].product == product) {
        index = i;
      }
    }
    return index;
  }

  void sumCart() {
    sumOfCart.value = 0;
    for (int i = 0; i < carts.length; i++) {
      sumOfCart.value += (carts[i].product.price * carts[i].numOfItem);
    }
  }

  bool isNewNotification() {
    bool returnBool = false;
    notifications.forEach((element) {
      if (!element.isSeen) {
        returnBool = true;
      }
    });
    return returnBool;
  }

  void setNotifications() {
    notifications.forEach((element) {
      element.isSeen = true;
    });
  }

  int numberOfNewNotifications() {
    int count = 0;
    notifications.forEach((element) {
      if (!element.isSeen) {
        count++;
      }
    });
    return count;
  }
}

enum Type { customer, cashier, none }

class ShoppingCard {
  String number;
  int cvs;
  int year;
  int month;

  ShoppingCard(this.number, this.cvs, this.year, this.month);

  Map<String, dynamic> toJson() {
    return {'number': number, 'cvs': cvs, 'year': year, 'month': month};
  }

  factory ShoppingCard.fromJson(Map<String, dynamic> json) =>
      ShoppingCard(json["number"], json["cvs"], json["year"], json["month"]);
}

class Order {
  DatabaseReference dataId = databaseReference;
  DateTime time;
  String id;
  String buyerId;
  List<Cart> carts = [];

  Order(this.time, this.id,this.buyerId, this.carts);

  Map<String, dynamic> toJson() {
    List<Map> carts = this.carts.map((i) => i.toJson()).toList();
    return {'time': time.toIso8601String(), 'id': id, 'buyerId': buyerId,'carts': carts};
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        DateTime.tryParse(json['time']) as DateTime,
        json["id"],
        json["buyerId"],
        List<Cart>.from(json["carts"].map((i) => Cart.fromJson(i))),
      );

  void update() {
    updateOrder(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }
}

AppUser createUser(record) {
  Map<String, dynamic> attributes = {
    'uid': '',
    'name': '',
    'image': '',
    'email': '',
    'password': '',
    'phoneNumber': '',
    'type': '',
    'wallet':'',
    'cards': [],
    'prevOrders': [],
    'carts': [],
    'notifications': []
  };

  record.forEach((key, value) => {attributes[key] = value});

  AppUser user = AppUser(
      attributes['uid'],
      attributes['name'],
      attributes['image'],
      attributes['email'],
      attributes['password'],
      attributes['phoneNumber'],
      intToType(attributes['type']),
      attributes['wallet'].toDouble()
  );
  String jsonCard = jsonEncode(attributes['cards']);
  String jsonOrder = jsonEncode(attributes['prevOrders']);
  String jsonCart = jsonEncode(attributes['carts']);
  String jsonNotification = jsonEncode(attributes['notifications']);
  var cardList = json.decode(jsonCard) as List;
  var orderList = json.decode(jsonOrder) as List;
  var cartList = json.decode(jsonCart) as List;
  var notificationList = json.decode(jsonNotification) as List;
  user.cards = cardList.map((i) => ShoppingCard.fromJson(i)).toList();
  user.prevOrders = orderList.map((i) => Order.fromJson(i)).toList();
  user.carts = cartList.map((i) => Cart.fromJson(i)).toList();
  user.notifications =
      notificationList.map((i) => UserNotification.fromJson(i)).toList();
  return user;
}

Order createOrder(record) {
  Map<String, dynamic> attributes = {
    'time': '',
    'id': '',
    'uid': '',
    'carts': []
  };

  record.forEach((key, value) => {attributes[key] = value});


  String jsonCart = jsonEncode(attributes['carts']);
  var cartList = json.decode(jsonCart) as List;
  Order order = Order(
      DateTime.tryParse(attributes['time']) as DateTime,
      attributes['id'],
      attributes['uid'],
      cartList.map((i) => Cart.fromJson(i)).toList());
  return order;
}

Type intToType(int type) {
  if (type == 0) {
    return Type.customer;
  } else if (type == 1) {
    return Type.cashier;
  } else {
    return Type.none;
  }
}
