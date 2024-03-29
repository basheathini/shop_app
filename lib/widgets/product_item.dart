import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

//    print('product rebuilds');
    //rounded corners wrapper
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () => {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id)
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            )
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border, color: Theme.of(context).accentColor,),
                onPressed: () {
                  product.isProductFavorite(auth.token, auth.userId);
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_basket,color: Theme.of(context).accentColor,),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: (){
                        cart.removeSingleItem(product.id);
                      } ,),
                  )
                );
              },
            ),
            title: Text(product.title, textAlign: TextAlign.center),
          ),

        ),

      );
  }
}
