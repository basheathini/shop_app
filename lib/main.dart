import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/products_overview_screen.dart';
import 'views/product_detail_screen.dart';
import 'providers/products.dart';
import 'providers/cart.dart';
import 'views/cart_screen.dart';
import 'providers/orders.dart';
import 'views/orders_screen.dart';
import 'views/user_product_screen.dart';
import 'views/edit_add_product_screen.dart';
import 'views/auth-screen.dart';
import 'providers/auth.dart';
import 'views/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Products()),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(value: Orders())
//      builder: (con) => Products(),
        ],
      child:  MaterialApp(
        title: 'Shop app',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'
        ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: AuthScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditAddProductScreen.routeName: (context) => EditAddProductScreen(),
          ProductsOverviewScreen.routeName: (context) => ProductsOverviewScreen()
        },
      ),
    );
  }
}
