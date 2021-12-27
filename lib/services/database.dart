
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final databaseReference =
FirebaseDatabase.instance.reference();
const String kFileName = 'remember.json';

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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/$kFileName');
}

Future saveRemember( Remember remember) async {
  final _filePath = await _localFile;

  Map<String, dynamic>  _newJson;

  bool exist = await _filePath.exists();

  if(!exist) {
    await _filePath.create();
    _newJson = remember.toMap();
  } else {
    _newJson =
    json.decode(_filePath.readAsStringSync());
    _newJson.addAll(remember.toMap());
  }
  String _jsonString = json.encode(_newJson);
  print(_jsonString);
  _filePath.writeAsString(_jsonString);
}

Future<Remember> getRemember() async {
  final _filePath = await _localFile;

  bool _fileExists = await _filePath.exists();

  Map<String, dynamic>  _json;
  if (_fileExists) {
    try {
      String _jsonString = await _filePath.readAsString();

      _json = jsonDecode(_jsonString);
      print(_json);
      return Remember.fromMap(_json);
    } catch (e) {
      print('Tried reading _file error: $e');
    }
  }
  return Remember('', '');
}


class Remember{
  String email;
  String password;

  Remember(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password
    };
  }

  factory Remember.fromMap(Map<String, dynamic> map) {
    return Remember(
         map['email'],
         map['password']
    );
  }
}

