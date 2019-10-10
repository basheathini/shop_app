import 'package:flutter/material.dart';
class CartItemDesign extends StatelessWidget {

  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItemDesign(this.id, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}