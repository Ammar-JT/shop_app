// Lesson 6: Update DB data via Patch Request + deleting DB data via HTTP Request

// Update DB data via Patch Request:
//        - transform updateProduct() into a Future function
//        - add async to the function, so the code will return a future by default
//

// deleting DB data via HTTP Request:
//        - very easy, see it in products.dart
//        - we simply hold the product object in a var and delete it from the list of object, and delete it from db
//        ..if it doesn't deleted from DB, we take this var and put it back to the list of object
//
//        - get and post request, if failed it push back a 4xx error, but delete won't do that
//        ..so if make http.delete().then().catchError() <<< it won't catch the error!!!
//        - What the solution? simply we through an exception!!
//        ..and this time we made a custom exception in models/http_exception.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
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
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
