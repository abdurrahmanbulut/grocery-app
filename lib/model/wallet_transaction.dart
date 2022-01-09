import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:grocery_app/services/database.dart';

class WalletTransaction {
  DatabaseReference dataId = databaseReference;
  DateTime time;
  double price;
  String buyerId;
  String sellerId;

  WalletTransaction(this.time, this.price, this.buyerId, this.sellerId);

  Map<String, dynamic> toJson() {
    return {
      'time':time.toIso8601String(),
      'price': price,
      'buyerId':buyerId,
      'sellerId': sellerId
    };
  }
  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
      DateTime.tryParse(json['time']) as DateTime,
      json["price"].toDouble(),
      json["buyerId"],
      json["sellerId"]
  );

  void update() {
    updateWallet(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }
}

WalletTransaction createWalletTransaction(record) {
  Map<String, dynamic> attributes = {
    'time': '',
    'price': '',
    'buyerId': '',
    'sellerId': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  WalletTransaction walletTransaction = WalletTransaction(
      DateTime.tryParse(attributes['time']) as DateTime,
      attributes['price'].toDouble(),
      attributes['buyerId'],
      attributes['sellerId']);
  return walletTransaction;
}