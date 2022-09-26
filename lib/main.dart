// Lesson 2: ChangeNotifierProxyProvider instead of ChangeNotifierProvider + Adding token to all requests

// ChangeNotifierProxyProvider instead of ChangeNotifierProvider
//      - why we used it instead? cuz we want to use auth as argument + we want the notifier to have a dependancy
//      - this notifier has a dependancy which is the prev regular provider (auth)
//      - if the auth notifier triggered, then this notifier proxy will be triggered too and will rebuild the products
//      - go and see it here in the main!

// Adding token to all requests:
//      - you can ether recieve the token from the args of the notifierProxyProvider here in main, we did it for products + orders
//      - or you can use the provider (Provider.of<Auth>(context, listen: false)), we did it in product_item to send it to product
//      -

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
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
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
