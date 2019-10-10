import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/products_overview_screen.dart';
import 'views/product_detail_screen.dart';
import 'providers/products.dart';
import 'providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Products()
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          )
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
        home: ProductsOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
