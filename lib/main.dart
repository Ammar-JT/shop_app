// Lesson 3: Connect 'Favorite' status to user not to all + Attach products to a user (creator) & filter by Creator + attatch orders to a user + add a logout functionality

// Connect 'Favorite" status to user not to all:
//      - we get the used id from the Auth provider to product_item (onPress) to product
//      - in product.dart we change patch with put, why? (i think i'm not 100% sure):
//          - .. cuz patch will append
//          - .. but put will replace
//      - the meaning of ??:
//          - isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
//        .. it means if the value is null, put this instead (put false instead in our case)
//      - lot's of easy logic, go and see it

// Attach products to a user (creator) & filter by Creator
//        - put createId in the http.post() request of the addProduct() in products.dart
//        - modify fetchAndSetProducts() to fetch only your product, and that is a server side thing,
//        .. so you only request the prodcuts that belong to you (instead of fetch all and filter in frontend)
//        - you modify fetchAndSetProducts() and put a dynamic args [bool filterByUser = false]
//        .. so you can show all products in products overview, and only your products in manage products
//
//        - use FutureBuilder in the body of user_products_screen,
//          ..why? cuz we need it to fetch the data again when you open manage product after you opened shop
//          ..which means the widget will be rebuild
//        - Wallahi too much logic about FutureBuilder that i didn't get it,
//          .. all these concepts comes from 'State Managment chapter', go see it when you need it

// attatch orders to a user:
//        - similar to products logic, but much easier
//        - added userId to the constructor in orders.dart
//        -

// add a logout functionality
//        - in auth.dart, add logout
//        - add logout to the drawer

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // <Auth, Products> = <Dynamic, Products> <<<<< this will look at Auth notifier before,
        // .. it find auth, so, the auth notifier will be a dependancy for this notifierProxy,
        // .. so once the Auth notifier triggered, this notifier proxy will be triggered also!
        // Products must be there by default, it's not a depandancy (dynamic or whatever)
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          // home: MyHomePage(),
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
