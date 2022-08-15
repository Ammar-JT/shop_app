// Lesson 4: turn of listener + change a model (like product) into a provider + nested providers + replace provider set up with index of the father provider + use the provider and pass values instead of using Stateful widgets

// turn of listener:
//      - you can turn of listener in the widget, it means it will use the provider,
//        ..but when the content of the provider change, the widget won't change.
//      - we did that in product_detail_screen, we changed:
//            - final loadedProduct = Provider.of<Products>(context).findById(productId);
//        to
//            - final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);

// change a model (like product) into a provider:
//      - just moved product from models to providers
//      - i used the mixin ChangeNotifier (using with)

// nested providers:
//      - products use product, both of them are providers now
//      - products setted up in main cuz their children needs products provider
//      - product setted up in the widget products_grid, cuz not the entire tree need it, only products_grid's children
//      - Notice that we don't use the constructor to pass data from products_grid to product_item
//        ..and that's obviously cuz we use providers, which means no need for constructor passing,
//        ..And if State changes, no need for Statefull widget!!!
//      - Stateful widget can be replaced with providers!

// replace provider set up with index of the father provider:
//      - in product grid, when we set up the product provider:
//        ..istead of using:
//            ChangeNotifierProvider( create: (c) => product(), child)
//        ..we simply used:
//            ChangeNotifierProvider( create: (c) => products[i], child)

// use the provider and pass values instead of using Stateful widgets:
//      - use the provider product in product_item
//      - put a toggle function in the provider
//      - use notifyListeners() in product provider
//      - notifyListeners() = setState() <<< تقريبا، اهم شي وصلك المعنى
//      - use toggleFavoriteStatus() in product_item widget
//      - make the favorite button toggable (put if and else to diplay icon filled if 1 and empty if 0)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // home: MyHomePage(),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
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
