import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import '../home_page.dart';
import 'components/product_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isChildPressed=false;
  int childIndex = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  isChildPressed? buildSubCategoryScreen() : buildCategoryScreen();
  }

  Widget buildCategoryScreen() {
    return Column(
      children: <Widget>[
        const PromotionList(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context,index) =>
                    buildCategoryCard(index)
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSubCategoryScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Container(
            color: Colors.transparent,
            child: SizedBox(
              width: 700,
              height: 60,
              child: Center(
                child: Text(categories[childIndex].name,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories[childIndex].size,
              itemBuilder: (context,index) => buildCategory(index)),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                  itemCount: categories[childIndex].subCategories[selectedIndex].productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.75,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context,index) =>
                      ProductCard(
                        product: categories[childIndex].subCategories[selectedIndex].productList[index],
                        press: (){},
                      ))
          ),
        )
      ],
    );
  }

  Widget buildCategoryCard(int categoryIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          childIndex = categoryIndex;
          isChildPressed = !isChildPressed;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(categories[categoryIndex].image),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              categories[categoryIndex].name,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  categories[childIndex].subCategories[index].name,
                  style: selectedIndex == index ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ) : const TextStyle(
                      color: Colors.black
                  ) ,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  height: 2,
                  width: 30,
                  color: selectedIndex == index ? Colors.amber : Colors.transparent,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
