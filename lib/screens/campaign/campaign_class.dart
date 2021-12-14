import 'package:flutter/material.dart';

class Campaign {
  final String image, title, description;

  Campaign({
    required this.image,
    required this.description,
    required this.title,
  });
}

List<Campaign> campaigns = [
  Campaign(
      image: "assets/images/chocolate.jpg",
      description: "Only for this weekend!",
      title: "%20 Sale in Chocolates!"),
  Campaign(
      image: "assets/images/milk.jpg",
      description: "Only for this weekend!",
      title: "%30 Sale in Milks!"),
  Campaign(
      image: "assets/images/tomatoes.jpg",
      description: "Only for this weekend!",
      title: "%40 Sale in Tomatoes!"),
  Campaign(
      image: "assets/images/potatoes.jpg",
      description: "Only for this weekend!",
      title: "%50 Sale in Potatoes!"),
  Campaign(
      image: "assets/images/chicken.jpg",
      description: "Only for this weekend!",
      title: "%60 Sale in Chickens!"),
  Campaign(
      image: "assets/images/meat.jpg",
      description: "Only for this weekend!",
      title: "%70 Sale in Meats!"),
];
