// Lesson 3: ......... + Mixin

// Providers & Listeners
//    - https://pub.dev/packages/provider/install
//    - make a provider folder and file name products.dart
//    - why providers? cuz without it you have to pass the data through the whole widget tree using constructors
//    .. and this shit is exausted + force the whole tree to re build the app
//    - To avoid the re build of the whole tree, we use providers

// ChangeNotifier (the mix in):
//    - use the mix in (which is like extends but lighter version)
//    - use the mix in ChangeNotifier in product.dart
//    - notifyListeners() is available when you use ChangeNotifier

//import provider on the top:
//    - if you need the provider in product_detail + product_overview,
//    .. then, you have to import the provider in their father, which is main
//    - So, import 'package:provider/provider.dart' here
//    - and Wrap the father widget you need (Material in our case) with ChangeNotifierProvider
//    - ChangeNotifierProvider comes from /provider.dart

//ChangeNotifierProvider:
//    - and Wrap the father widget you need (Material in our case) with ChangeNotifierProvider
//    - ChangeNotifierProvider comes from /provider.dart
//    - use the argument create (or builder in older versions)
//    .. in our case:      create: (ctx) => Products(),
//    - now doing all of that, when a changes happen to the provider, it won't re build the whole tree, (not even the main)
//    .. instea, only the widget that listen to the provider will be changed

// some changes:
//    - i separate product_grid from product_overview_screen

// Provider.of(context):
//    - this is the method the give you the access to the provider
//    - we used it in products_grid: Provider.of<Products>(context);

//Mixin:
//    - https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15121178?start=30#announcements
//    - same as inheritence (extends), but you can (with) many Mixins
//    .. unlike inhertience you can (extends only one class)
//    - a theoritical difference is that there is strong connection between class and its parent class (the inheritor)
//    .. unlike the Mixin, it's only a general functions and propery
//    - Car can (extends) one parent like transportation (which has strong connection),
//    .. but it can (with) many Mixins like agility, sizes, and so on... (were they has a weak connection and can be used with other like animals and devices)

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
