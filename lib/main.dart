// Lesson 1: Install and setup firebase + Sending Post Request + Future and http.post().then

//Install and setup firebase
//      - install is very easy, just add depandacy in pubspec.yaml
//      - https://pub.dev/packages/http/install
//      - create new firebase project and make a realtime DB
//      - this firebase db will act as any other API..
//        .. yeah, exactally like the APIs you make with Laravel

// Sending Post Request:
//      - better to not do the logic in the UI widgets, so it will be in products.dart
//      - just use http.post() <<< go and see products.dart

// Future and http.post().then:
//      - same http resquest send and response, no need to explain
//      - after you send request, if there is a changable UI logic after that request,
//      .. simply put it inside .then()

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
