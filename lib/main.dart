// Lesson 5: create (builder) vs .value + Provider.of<Product>(context) vs Consumer<Product>

// create (builder) vs .value <<<< both for setting up the provider
//      - you we used builder here in main:
//            ChangeNotifierProvider( create: (ctx) => Products(), .....)
//      - we can also use .value:
//            ChangeNotifierProvider.value( value: Products(), .....)
//      - So, what's the different between them?
//            - create: is used when you need the context (honestly I donno when we need context أصلا)
//            - .value: is used when you don't need context
//            - create: is perfect when you instantiate the object (like here in main)
//            - .value: is perfect when you reuse a already-instantiated object (like in products_grid, or anything that part of a list or grid),
//              ..(in products_grid: we're cycling in a list of products that already exist (unlike main we build a whole new widget))

// Provider.of<Product>(context) vs Consumer<Product>: <<<<< both for using the provider and listen to its changes
//      - both used to listen to data changes in the provider
//      - what's the different?
//          - of(context) will re build the entire widget that listened to the change in provider
//          - consumer will also re build the entire widget (only if you use it to replace of(context entirely)), but....
//          - if you use both of(context) and consumer at the same time,
//            .. then there is no need for the full build of the widget!!!!
//      - to take the advantage of not rebuilding the whole widget, use of(context) in the widget and turn of the listen,
//        .. and use consumer in a very specific parts, the parts that changing when listening.

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
