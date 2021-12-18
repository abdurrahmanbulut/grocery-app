import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:grocery_app/services/database.dart';

class Product {
  String pid = '';
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

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'image':image,
      'price':price,
      'desc':desc,
      'discount':discount,
      'count':count,
      'id':id
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    json["name"],
    json["image"],
    json["price"].toDouble(),
    json["desc"],
    json["discount"].toDouble(),
    json["count"],
    json["id"],
  );
}

class SubCategory {
  String name;
  String id = '';
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

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productList =  this.productList.map((i) => i.toJson()).toList();
    return {
      'name':name,
      'productList':productList
    };
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    json["name"],
    List<Product>.from(json["productList"].map((i) => Product.fromJson(i))),
  );

}

class CategoryProduct {
  DatabaseReference dataId = databaseReference;
  String id = '';
  String name;
  String image;
  List<SubCategory> subCategories = [];

  CategoryProduct(this.name,this.image);

  get size => subCategories.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryProduct &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> subCategories =  this.subCategories.map((i) => i.toJson()).toList();
    return {
      'name':name,
      'image':image,
      'subCategories':subCategories
    };
  }

  void update() {
    updateCategory(this, dataId);
  }

  void setId(DatabaseReference id) {
    dataId = id;
  }
}

CategoryProduct createCategory(record) {
  Map<String, dynamic> attributes = {
    'name':'',
    'image':'',
    'subCategories': []
  };
  record.forEach((key, value) => {attributes[key] = value});
  CategoryProduct category = CategoryProduct(attributes['name'],attributes['image']);
  String jsonString = jsonEncode(attributes['subCategories']);
  var list = json.decode(jsonString) as List;
  category.subCategories = list.map((i)=>SubCategory.fromJson(i)).toList();
  return category;
}


List<Product> demoProducts = [
  Product("1Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("qqq Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 02),
  Product("22222 Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 03),
  Product("3 Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 04),

];


class Cart {
  final Product product;
  int numOfItem;

  Cart({required this.product, required this.numOfItem});

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'numOfItem':numOfItem
    };
  }
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      product: json["product"],
      numOfItem: json["numOfItem"]
  );
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 4),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[2], numOfItem: 1),

];




