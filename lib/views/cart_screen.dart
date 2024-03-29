import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import '../views/square_payment_system_screen.dart';


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
              OrderButton(cart: cart)
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

enum ApplePayStatus { success, fail, unknown }
class OrderButton extends StatefulWidget {

//  final bool applePayEnabled;
//  final bool googlePayEnabled;
//  final String squareLocationId;
//  final String applePayMerchantId;
  static final GlobalKey<ScaffoldState> scaffoldKey =
  GlobalKey<ScaffoldState>();


  const OrderButton({
    Key key,
    @required this.cart,
    }) : super(key: key);

  final Cart cart;


  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async{

        setState(() {
          _isLoading = true;
        });

        await Provider.of<Orders>(context, listen: false).addOrders(
            widget.cart.items.values.toList(),
            widget.cart.totalAmount
        );

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushReplacementNamed(PaymentSystem.routeName);

        widget.cart.clearItems();
      },
      textColor: Theme.of(context).primaryColor ,
    );
  }
}

