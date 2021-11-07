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

  Category(this.name,this.image);

  get size => subCategories.length;

  void addSubCategory(String categoryName) {
    subCategories.add(SubCategory(categoryName));
  }
  SubCategory getSubCategory(String categoryName) {
    for(int i=0;i<size;i++) {
      if(subCategories[i].name == categoryName) {
        return subCategories[i];
      }
    }
    return SubCategory("null");
  }
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

  SubCategory(this.name);

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

List<Category> categories = [
  Category("Beverage","image"),
  Category("Snack","image"),
  Category("Ice-cream","image"),
  Category("Water","image"),
  Category("Milk & Breakfast","image"),
  Category("Fruit & Vegetables","image"),
  Category("Bread","image"),
  Category("Convenience Food","image"),
];




