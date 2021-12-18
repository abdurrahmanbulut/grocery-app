import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/utilities/google_sign_in.dart';
import 'package:provider/provider.dart';

Future main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  List<CategoryProduct> categories = await getAllCategories();
   runApp(App(categories));
}

class App extends StatelessWidget {
  final List<CategoryProduct> categories;
  const App(this.categories,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider (
    
    create: (context ) => GoogleSignInProvider(),
    child: MaterialApp(
      
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Splash(categories),
    ),
  );
}
