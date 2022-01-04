import 'package:firebase_database/firebase_database.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/promotion.dart';
import 'package:grocery_app/model/user.dart';

final databaseReference =
FirebaseDatabase.instance.reference();
AppUser appUser = AppUser('', '', '', '', '', '', Type.none,0.0);


DatabaseReference saveUser(AppUser user) {
  var id = databaseReference.child('users/').push();
  id.set(user.toJson());
  return id;
}

Query getUserQuery() {
  return databaseReference.child('users/');
}

void updateUser(AppUser user, DatabaseReference id) {
  id.update(user.toJson());
}

Future<List<AppUser>> getAllUsers() async {
  DataSnapshot dataSnapshot = await databaseReference.child('users/').once();
  List<AppUser> users = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      AppUser user = createUser(value);
      user.setId(databaseReference.child('users/' + key));
      users.add(user);
    });
  }
  return users;
}

DatabaseReference saveCategory(CategoryProduct category) {
  var id = databaseReference.child('categories/').push();
  id.set(category.toJson());
  return id;
}

Query getCategoryQuery() {
  return databaseReference.child('categories/');
}

void updateCategory(CategoryProduct category, DatabaseReference id) {
  id.update(category.toJson());
}

Future<List<CategoryProduct>> getAllCategories() async {
  DataSnapshot dataSnapshot = await databaseReference.child('categories/').once();
  List<CategoryProduct> categories = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      CategoryProduct category = createCategory(value);
      category.setId(databaseReference.child('categories/' + key));
      categories.add(category);
    });
  }
  return categories;
}

List<Product> getAllProducts(List<CategoryProduct> categories){
  List<Product> products = [];
  categories.forEach((element) {
    element.subCategories.forEach((subElement) {
      subElement.productList.forEach((productElement) {
        products.add(productElement);
      });
    });
  });
  return products;
}


List<Product> getFilteredProducts(List<CategoryProduct> categories,String keyword) {
  List<Product> products = getAllProducts(categories);
  List<Product> filteredProducts = [];
  products.forEach((element) {
    if(element.contains(keyword)) {
      filteredProducts.add(element);
    }
  });
  return filteredProducts;
}

DatabaseReference saveOrder(Order order) {
  var id = databaseReference.child('orders/').push();
  id.set(order.toJson());
  return id;
}

Query getOrderQuery() {
  return databaseReference.child('orders/');
}

void updateOrder(Order order, DatabaseReference id) {
  id.update(order.toJson());
}

Future<List<Order>> getAllOrders() async {
  DataSnapshot dataSnapshot = await databaseReference.child('orders/').once();
  List<Order> orders = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Order order = createOrder(value);
      order.setId(databaseReference.child('orders/' + key));
      orders.add(order);
    });
  }
  return orders;
}

Future<List<Promotion>> getAllPromotions() async {
  DataSnapshot dataSnapshot = await databaseReference.child('promotions/').once();
  List<Promotion> promotions = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Promotion order = createPromotion(value);
      promotions.add(order);
    });
  }
  return promotions;
}

