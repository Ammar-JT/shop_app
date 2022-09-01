// Lesson 2: change addProduct function in products.dart to a function that return Future + waiting indicator

// change addProduct function in products.dart to a function that return Future:
//       - it's just a small change, but fantastic!
//       - go and see it in proudcts.dart
//       - now in edit_product_screen.dart, we can use then cuz we hava a returned future!
//       - and we will use .then, and inside it we use the pop and

// waiting indicator:
//       - make a _isLoading var in edit_product_screen.dart
//       - use it inside .then inside a setState() ofcourse
//       - this _isLoading will be in if else to make the edit_product_screen.dart
//         .. decide to display indicator or display the widget tree
//       - we used it in edit_product_screen >>> body: _isLoading ? indicator : widget tree logic

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
