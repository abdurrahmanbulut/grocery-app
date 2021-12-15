
import 'package:firebase_database/firebase_database.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';

final databaseReference =
FirebaseDatabase.instance.reference();

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

DatabaseReference saveCategory(Category category) {
  var id = databaseReference.child('categories/').push();
  id.set(category.toJson());
  return id;
}

Query getCategoryQuery() {
  return databaseReference.child('categories/');
}

void updateCategory(Category category, DatabaseReference id) {
  id.update(category.toJson());
}

Future<List<Category>> getAllCategories() async {
  DataSnapshot dataSnapshot = await databaseReference.child('categories/').once();
  List<Category> categories = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Category category = createCategory(value);
      category.setId(databaseReference.child('categories/' + category.name));
      categories.add(category);
    });
  }
  return categories;
}