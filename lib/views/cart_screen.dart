import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             Padding(
               padding: EdgeInsets.all(8),
               child:  Text(
                 'Total', style: TextStyle(fontSize: 20),
               ),
             ),

              Spacer(),
//              SizedBox(width: 10,),
              Chip(
                label: Text(
                  'R${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(color:Theme.of(context).primaryTextTheme.title.color ),),
                backgroundColor: Theme.of(context).primaryColor,),
              FlatButton(
                child: Text('ORDER NOW'),
                onPressed: (){
                  Provider.of<Orders>(context, listen: false).addOrders(cart.items.values.toList(), cart.totalAmount);
                  cart.clearItems();
                },
                textColor: Theme.of(context).primaryColor ,
              )
            ],
          ),
        ),
        SizedBox(height: 10,),
        //listview inside of a column doesn't work
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => CartItemDesign(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title
            ),
            itemCount: cart.items.length,
          ),
        )


      ],
      ),

    );
  }
}
