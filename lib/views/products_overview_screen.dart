import 'package:flutter/material.dart';
import 'package:shop_app/views/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';

enum filteringOptions{
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen>{
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  //runs once before everything runs.
  @override
  void initState() {
    //Provider.of<Products>(context).fetchProducts(); won't work because we need the context and it is not fully loaded.

    //Future is a hack that kind of delays the execution of getting products so that the context can be available
//    Future.delayed(Duration.zero).then((_) {
//      Provider.of<Products>(context).fetchProducts();
//    });
    super.initState();
  }

  //gets executed often, so we need a way to check if its been ran.
  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_){
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
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filteringOptions selectedValue){
              setState(() {
                if(selectedValue == filteringOptions.Favorites){
                  _showOnlyFavorites = true;
//                productsContainer.showFavoritesOnly();
                }else{
                  _showOnlyFavorites = false;
//                productsContainer.showAll();
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: filteringOptions.Favorites,),
              PopupMenuItem(
                child: Text('Show all'),
                value: filteringOptions.All,)

            ],),
          Consumer<Cart>(
            builder: ( _, cart, ch) => Badge(
              child: ch,
            value: cart.itemCount.toString(),

          ),
            child: IconButton(
              icon: Icon(
                  Icons.shopping_cart
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),

        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ProductsGrid(_showOnlyFavorites),
    );
  }

}
