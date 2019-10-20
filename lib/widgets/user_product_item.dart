import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../views/edit_add_product_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({@required this.id ,@required this.title, @required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 96,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                    EditAddProductScreen.routeName,
                    arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);

              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
