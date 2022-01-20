import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/notification.dart';
import 'package:grocery_app/model/wallet_transaction.dart';

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
  List<WalletTransaction> walletTransactions = [];

  AppUser(this.uid, this.name, this.image, this.email, this.password,
      this.phoneNumber, this.type, this.wallet);

  Map<String, dynamic> toJson() {
    List<Map> cards = this.cards.map((i) => i.toJson()).toList();
    List<Map> prevOrders = this.prevOrders.map((i) => i.toJson()).toList();
    List<Map> carts = this.carts.map((i) => i.toJson()).toList();
    List<Map> notifications =
        this.notifications.map((i) => i.toJson()).toList();
    List<Map> walletTransactions =
        this.walletTransactions.map((i) => i.toJson()).toList();
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'type': (type == Type.customer) ? 0 : 1,
      'wallet': wallet,
      'cards': cards,
      'prevOrders': prevOrders,
      'carts': carts,
      'notifications': notifications,
      'walletTransactions': walletTransactions
    };
  }

  void update() {
    updateUser(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }

  List<Order> getDailyOrders() {
    List<Order> dailyOrders = [];
    prevOrders.forEach((element) {
      if (element.time.day == DateTime.now().day && (element.status != OrderStatus.taken && element.status != OrderStatus.canceled) ) {
        dailyOrders.add(element);
      }
    });
    return dailyOrders;
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
      '',
      json["email"],
      json["password"],
      json["phoneNumber"],
      intToType(json["type"]),
      json["wallet"]);

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
      sumOfCart.value += (carts[i].product.getDiscountedPrice() * carts[i].numOfItem);
    }
  }

  double sumOrder(int index) {
    double sumofOrder = 0.0;
    for (int i = 0; i < prevOrders[index].carts.length; i++) {
      sumofOrder += (prevOrders[index].carts[i].product.getDiscountedPrice() *
          prevOrders[index].carts[i].numOfItem);
    }
    return sumofOrder;
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

  bool contains(String keyword) {
    return (email.toUpperCase().contains(keyword.toUpperCase()));
  }

  void addWallet(double value) {
    wallet = wallet + value;
  }

  void decreaseWallet(double value) {
    wallet = wallet - value;
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
  OrderStatus status;
  bool paid;

  Order(this.time, this.id, this.buyerId, this.carts, this.status,this.paid);

  Map<String, dynamic> toJson() {
    List<Map> carts = this.carts.map((i) => i.toJson()).toList();
    return {
      'time': time.toIso8601String(),
      'id': id,
      'buyerId': buyerId,
      'carts': carts,
      'status': statusToInt(status),
      'paid': paid
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      DateTime.tryParse(json['time']) as DateTime,
      json["id"],
      json["buyerId"],
      List<Cart>.from(json["carts"].map((i) => Cart.fromJson(i))),
      intToStatus(json["status"]),json["paid"]);

  void update() {
    updateOrder(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }

  double sumOrder2() {
    double sumofOrder = 0.0;
    for (int i = 0; i < carts.length; i++) {
      sumofOrder += (carts[i].product.price * carts[i].numOfItem);
    }
    return sumofOrder;
  }

  bool contains(String keyword) {
    return (id.toUpperCase().contains(keyword.toUpperCase()));
  }
}

enum OrderStatus { waiting, prepared, taken, canceled }

AppUser createUser(record) {
  Map<String, dynamic> attributes = {
    'uid': '',
    'name': '',
    'email': '',
    'password': '',
    'phoneNumber': '',
    'type': '',
    'wallet': '',
    'cards': [],
    'prevOrders': [],
    'carts': [],
    'notifications': [],
    'walletTransactions': []
  };

  record.forEach((key, value) => {attributes[key] = value});

  AppUser user = AppUser(
      attributes['uid'],
      attributes['name'],
      '',
      attributes['email'],
      attributes['password'],
      attributes['phoneNumber'],
      intToType(attributes['type']),
      attributes['wallet'].toDouble());
  String jsonCard = jsonEncode(attributes['cards']);
  String jsonOrder = jsonEncode(attributes['prevOrders']);
  String jsonCart = jsonEncode(attributes['carts']);
  String jsonNotification = jsonEncode(attributes['notifications']);
  String jsonWalletTransactions = jsonEncode(attributes['walletTransactions']);
  var cardList = json.decode(jsonCard) as List;
  var orderList = json.decode(jsonOrder) as List;
  var cartList = json.decode(jsonCart) as List;
  var notificationList = json.decode(jsonNotification) as List;
  var walletTransactionsList = json.decode(jsonWalletTransactions) as List;
  user.cards = cardList.map((i) => ShoppingCard.fromJson(i)).toList();
  user.prevOrders = orderList.map((i) => Order.fromJson(i)).toList();
  user.carts = cartList.map((i) => Cart.fromJson(i)).toList();
  user.notifications =
      notificationList.map((i) => UserNotification.fromJson(i)).toList();
  user.walletTransactions =
      walletTransactionsList.map((i) => WalletTransaction.fromJson(i)).toList();
  return user;
}

Order createOrder(record) {
  Map<String, dynamic> attributes = {
    'time': '',
    'id': '',
    'buyerId': '',
    'carts': []
  };

  record.forEach((key, value) => {attributes[key] = value});

  String jsonCart = jsonEncode(attributes['carts']);
  var cartList = json.decode(jsonCart) as List;
  Order order = Order(
      DateTime.tryParse(attributes['time']) as DateTime,
      attributes['id'],
      attributes['buyerId'],
      cartList.map((i) => Cart.fromJson(i)).toList(),
      intToStatus(attributes['status']),attributes['paid']);
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

OrderStatus intToStatus(int status) {
  if (status == 0) {
    return OrderStatus.waiting;
  } else if (status == 1) {
    return OrderStatus.prepared;
  } else if (status == 2) {
    return OrderStatus.taken;
  } else {
    return OrderStatus.canceled;
  }
}

int statusToInt(OrderStatus status) {
  if (status == OrderStatus.waiting) {
    return 0;
  } else if (status == OrderStatus.prepared) {
    return 1;
  } else if (status == OrderStatus.taken) {
    return 2;
  } else {
    return 3;
  }
}
