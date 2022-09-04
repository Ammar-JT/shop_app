// Lesson 5: Fetching data from DB & initState & of(context) + Transform fetched DB Data + Pull-To-Refresh

//  Fetching data from DB & initState & of(context):
//      - too much logic, you can find it in
//          - products.dart: fetchAndSetProducts
//          - products_overview_screen.dart: initState() and didChangeDependencies()
//      - data will be fetched as json, we have to transform it to display it

// Transform fetched DB Data:
//      - all logic happened in product.dart: fetchAndSetProducts()
//      - no need to explain, it's easy
//      - i also used the loading indicator in product_overview_screen.dart

// Pull-To-Refresh
//      - all logic is in user_products_screen.dart
//      - specifically in _refreshProducts() and RefreshIndicator

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
