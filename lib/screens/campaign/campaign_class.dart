import 'package:flutter/material.dart';

class Campaign {
  final String image, title, description, product;

  Campaign({
    required this.image,
    required this.description,
    required this.title,
    required this.product,
  });
}

List<Campaign> campaigns = [
  Campaign(
      image: "assets/images/chocolate.jpg",
      description: "Only for this weekend!",
      title: "%20 Sale in Chocolates!",
      product: "Chocolate"),
  Campaign(
      image: "assets/images/milk.jpg",
      description: "Only for this weekend!",
      title: "%30 Sale in Milks!",
      product: "Tea"),
  Campaign(
      image: "assets/images/tomatoes.jpg",
      description: "Only for this weekend!",
      title: "%40 Sale in Tomatoes!",
      product: "Ayran"),
  Campaign(
      image: "assets/images/potatoes.jpg",
      description: "Only for this weekend!",
      title: "%50 Sale in Potatoes!",
      product: "Coffe"),
  Campaign(
      image: "assets/images/chicken.jpg",
      description: "Only for this weekend!",
      title: "%60 Sale in Chickens!",
      product: "Fruit Juice"),
  Campaign(
      image: "assets/images/meat.jpg",
      description: "Only for this weekend!",
      title: "%70 Sale in Meats!",
      product: "Coca Cola")
];
