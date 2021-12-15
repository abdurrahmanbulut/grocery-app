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

  Product.fromSnapshot(DataSnapshot snapshot) :
        pid = snapshot.key!,
        name = snapshot.value["name"]!,
        image = snapshot.value["image"]!,
        price = snapshot.value["price"]!,
        desc = snapshot.value["desc"]!,
        discount = snapshot.value["discount"]!,
        count = snapshot.value["count"]!,
        id = snapshot.value["id"]!;
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

  SubCategory.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key!,
        name = snapshot.value["name"]!,
        productList = snapshot.value["productList"];
}

class Category {
  DatabaseReference dataId = databaseReference;
  String id = '';
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

  Category.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key!,
        image = snapshot.value["image"]!,
        name = snapshot.value["name"]!,
        subCategories = snapshot.value["subCategories"];

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



Category createCategory(record) {
  Map<String, dynamic> attributes = {
    'name':'',
    'image':'',
    'subCategories':[]
  };

  record.forEach((key, value) => {attributes[key] = value});

  Category category = Category(attributes['name'],attributes['image'],List.from(attributes['subCategories']));
  return category;
}

List<Product> sodaList = [
  Product("1Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01 ),
  Product("3Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Coca Cola", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory soda = SubCategory("Soda", sodaList);

List<Product> teaList = [
  Product("1Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("3Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Tea", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory tea = SubCategory("Cold Tea & Coffee", teaList);

List<Product> ayranList = [
  Product("1Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("3Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Ayran", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory ayran = SubCategory("Ayran", ayranList);

List<Product> coffeeList = [
  Product("1Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("3Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Coffee", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory coffee = SubCategory("Coffee", coffeeList);

List<Product> juiceList = [
  Product("1Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("3Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Fruit Juice", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory juice = SubCategory("Fruit Juice", juiceList);

List<SubCategory> beveragesub = [
  soda,tea,ayran,coffee,juice
];

List<Product> chocolateList = [
  Product("1Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("2Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("3Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01),
  Product("4Chocolate Bar", "assets/images/products/img01.png", 10, "cola desc", 0, 0, 01)
];
SubCategory choco = SubCategory("Chocolate", chocolateList);


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
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 4),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[2], numOfItem: 1),

];




