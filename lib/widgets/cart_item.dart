import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
class CartItemDesign extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemDesign(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (con) => AlertDialog(
          title: Text(
              'Are you sure'
          ),
          content: Text(
              'Do you want to remove the item from the cart'
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(con).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(con).pop(true);
              },
            )
          ],
        ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context,listen: false ).removeItem(productId);

      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child:  Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('R$price'),
                  ),
                )
            ),
            title: Text(title),
            subtitle: Text('Total: R${price * quantity}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}


