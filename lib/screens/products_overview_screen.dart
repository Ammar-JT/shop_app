import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/cart.dart';

import './cart_screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // <<< this won't work here, cuz widget is not fully wired up with initstate here // <<<<<< دا كان كلام ماكسيموس بس تحليلي انا للموضوع انه لسا الويدجت ما انبنت اصلا فما ينفع تستخدم اشيا مررة محددة كدا

    // to work around that, you can use future, so it happend a little bit late, and in parallel:
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });

    // or you can simply use didChangeDependencies() <<<< الحمار ماكسيموس كان المفروض يستخدمها من البداية
    super.initState();
  }

  //this is great way to use .fetchAndSetProducts() cuz it's working not from the begining, no it's a little bit delayed
  //but ofcourse the problem here that is this function will be called multiple time,
  //.. so make sure to have a _variable that make sure it called one time only
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavoritesOnly),
    );
  }
}
