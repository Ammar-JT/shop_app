// Lesson 6:  make an action buttons (PopupMenuButton) + local state vs app wide state (stateful vs provider) + changed to stateful

//make an action buttons (PopupMenuButton):
//    - made it in product_overview_screen
//    - used enum for the buttons value
//    - made two function in products.dart to bring favorites, or bring all

// local state vs app wide state:
//    - the previous was bad practise, why? cuz favorite products + all product is needed in the widget only (product_overview_screen)
//      .. not the whole app..
//    - if that the case then we should use stateful widget, and remove the function of product.dart to this stateful widget
//    - in this lesson i will have the first commit with the provider functions showFavoritesOnly() + showAll()
//    - in the next commit the functions will be moved to the local state (or local widget)
//      .. and the widget will be stateful widget!

// change to stateful (ProductOverviewScreen):
//    - (products.dart) delete the app wide state functions from the provider products.dart (showFavoritesOnly() + showAll())
//    - put favoriteItems getter in products.dart
//
//    - change products_overview_screen to stateful
//    - remove the provider.of(context)
//    - put property _showFavoritesOnly
//    - pass it to products_grid
//    - now wrape the lofic inside onSelected (if else) with setState

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
      // value: Products(), <<< not best practise, cuz it's not part of a list or grid, it's main!
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
