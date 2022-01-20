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

  bool contains(String keyword) {
    return (name.toUpperCase().contains(keyword.toUpperCase()));
  }

  double getDiscountedPrice() {
    return price  - (price*discount/100);
  }
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

class Cart {
  final Product product;
  int numOfItem = 0;

  Cart({required this.product, required this.numOfItem});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'numOfItem':numOfItem
    };
  }
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      product: Product.fromJson(json["product"]),
      numOfItem: json["numOfItem"]
  );
}

// Demo data for our cart





