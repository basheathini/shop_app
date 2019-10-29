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
import 'views/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            builder: (ctx, auth, previousProducts) => Products(auth.token, auth.userId , previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProxyProvider<Auth, Orders> (
            builder: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId ,previousOrders == null ? [] : previousOrders.orders),
          ),
//          ChangeNotifierProvider.value(value: Orders())
//      builder: (con) => Products(),
        ],
      child: Consumer<Auth>(builder: (ctx, auth, _) => MaterialApp(
        title: 'Shop app',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'
        ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(
          future : auth.autoLogin(), builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditAddProductScreen.routeName: (context) => EditAddProductScreen(),
          ProductsOverviewScreen.routeName: (context) => ProductsOverviewScreen()
        },
      ) ,),
    );
  }
}
