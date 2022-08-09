// Lesson 1: Setting up project + add a product grid + some themes + ClipRRect (Clip Round Rectangle)

// Setting up project
//    - stateless main
//    - create sructure of the project: models folder + product.dart + screens folder + product_overview_screen

// add a product grid:
//    - added a product_item widget
//    - added product grid to product_overview_screen
//    - used product_item in the product grid of product_overview_screen
//    - in product_item: display title + favorite icon + cart icon
//    - some themes

// ClipRRect:
//    - just to make border more rounded
//    - go and see it in product_item
import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      // home: MyHomePage(),
      home: ProductOverviewScreen(),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MyShop'),
//       ),
//       body: const Center(
//         child: Text('Let\'s build a shop!'),
//       ),
//     );
//   }
// }
