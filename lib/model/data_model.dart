
import 'package:flutter/material.dart';

class Product {
  String name;
  String image;
  double price;
  String desc;
  double discount;
  int count;
  int id;

  Product(this.name, this.image, this.price, this.desc, this.discount, this.count, this.id);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;


}
class Category {
  String name;
  String image;
  List<SubCategory> subCategories = [];

  Category(this.name,this.image,this.subCategories);

  get size => subCategories.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class SubCategory {
  String name;
  List<Product> productList = [];

  SubCategory(this.name,this.productList);

  get size => productList.length;

  void addProduct(Product product) {
    productList.add(product);
  }

  Product getProduct(String name) {
    for(int i=0;i<size;i++) {
      if(productList[i].name == name) {
        return productList[i];
      }
    }
    return Product("null", "null", 0, "null", 0, 0, 0);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategory &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;


}
List<Product> sodaList = [
 Product("1Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01 ),
  Product("3Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory soda = SubCategory("Soda", sodaList);

List<Product> teaList = [
  Product("1Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("3Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory tea = SubCategory("Cold Tea & Coffee", teaList);

List<Product> ayranList = [
  Product("1Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("3Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory ayran = SubCategory("Ayran", ayranList);

List<Product> coffeeList = [
  Product("1Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("3Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory coffee = SubCategory("Coffee", coffeeList);

List<Product> juiceList = [
  Product("1Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("3Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory juice = SubCategory("Fruit Juice", juiceList);

List<SubCategory> beveragesub = [
  soda,tea,ayran,coffee,juice
];

List<Product> chocolateList = [
  Product("1Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("2Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("3Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01),
  Product("4Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 50, 01)
];
SubCategory choco = SubCategory("Chocolate", chocolateList);

class Cart {
  final Product product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}



List<Product> demoProducts = [
  Product("6 Pack Milk","assets/images/2.jpg",45.0,"Semi-skimmed pasteurized milk.",2.0,10,1),
  Product("XL 30 Eggs","assets/images/3.jpg",5.0,"Kingsize eggs.",2.0,10,2),
  Product("Butter","assets/images/4.jpg",5.0,"400g packet butter.",2.0,10,3),
  Product("Rye Bread","assets/images/1.jpg",5.0,"350g packet bread.",2.0,10,4),
];

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
  Cart(product: demoProducts[2], numOfItem: 1),
];





List<SubCategory> snacksub = [
  choco,tea,ayran,coffee,juice
];

List<Category> categories = [
  Category("Beverage","assets/images/products/img01.png",beveragesub),
  Category("Snack","assets/images/products/img01.png",snacksub),
  Category("Ice-cream","assets/images/products/img01.png",beveragesub),
  Category("Water","assets/images/products/img01.png",beveragesub),
  Category("Milk & Breakfast","assets/images/products/img01.png",beveragesub),
  Category("Fruit & Vegetables","assets/images/products/img01.png",beveragesub),
  Category("Bread","assets/images/products/img01.png",beveragesub),
  Category("Convenience Food","assets/images/products/img01.png",beveragesub),
  Category("Staple Food","assets/images/products/img01.png",beveragesub),
  Category("Fit & Form","assets/images/products/img01.png",beveragesub),
  Category("Personal Care","assets/images/products/img01.png",beveragesub),
  Category("Home Care","assets/images/products/img01.png",beveragesub),
  Category("Cosmetics","assets/images/products/img01.png",beveragesub),
];