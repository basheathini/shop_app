import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/product_detail_screen.dart';
import '../providers/product.dart';
class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  //positional arguments
//  ProductItem(this.id, this.title, this.imageUrl);
  
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    print('product rebuilds');
    //rounded corners wrapper
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () => {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id)
            },
            child: Image.network(product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border, color: Theme.of(context).accentColor,),
                onPressed: () {
                  product.isProductFavorite();
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_basket,color: Theme.of(context).accentColor,),
              onPressed: () => {},
            ),
            title: Text(product.title, textAlign: TextAlign.center),
          ),

        ),

      );
  }
}
