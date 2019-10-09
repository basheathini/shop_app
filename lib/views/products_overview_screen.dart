import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

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

            ],)

        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }

}
