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
      image: "assets/images/sırma.jpg",
      description: "Sadece bu hafta için!",
      title: "Sırma ürünlerinde %10 indirim!",
      product: "Sırma"),
  Campaign(
      image: "assets/images/sütaş.jpg",
      description: "Sadece bu hafta için!",
      title: "Süt ürünlerinde %10 indirim.!",
      product: "Sütaş"),
  Campaign(
      image: "assets/images/cappy.jpg",
      description: "Sadece bu hafta için!",
      title: "Cappy ürünlerinde %10 indirim!",
      product: "Cappy"),
  Campaign(
      image: "assets/images/indomie.png",
      description: "Sadece bu hafta için!",
      title: "Indomie noodlelarda %10 indirim!",
      product: "Noodle"),
  Campaign(
      image: "assets/images/filiz.jpg",
      description: "Sadece bu hafta için!",
      title: "Filiz makarnalarda %10 indirim!",
      product: "Makarna"),
  Campaign(
      image: "assets/images/damacana.jpg",
      description: "Sadece bu hafta için!",
      title: "Damacanalarda %10 indirim",
      product: "19L")
];
