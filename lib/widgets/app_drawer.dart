import 'package:flutter/material.dart';
import '../views/orders_screen.dart';
import '../views/user_product_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../views/square_payment_system_screen.dart';
import '../helpers/custom_route_helper.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(
                Icons.shop
            ),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Icons.shopping_cart
            ),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              ///Navigator.of(context).pushReplacement(CustomRouteHelper(builder: (ctx) => OrdersScreen(),));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Icons.edit
            ),
            title: Text('Manage Products'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Icons.payment
            ),
            title: Text('Payment'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(PaymentSystem.routeName);
            },
          ),
//          Divider(),
//          ListTile(
//            leading: Icon(
//                Icons.history
//            ),
//            title: Text('History'),
//            onTap: (){
//              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
//            },
//          ),
//          Divider(),
//          ListTile(
//            leading: Icon(
//                Icons.trending_up
//            ),
//            title: Text('Promo'),
//            onTap: (){
//              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
//            },
//          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).signOut();
              //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
