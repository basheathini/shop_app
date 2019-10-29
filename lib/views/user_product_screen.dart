import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../views/edit_add_product_screen.dart';
class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //var products = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer() ,
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditAddProductScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: () => _refreshProducts(context),//anonymous function
          child: Consumer<Products> (
            builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (_, index) => Column(
                  children: <Widget>[
                    UserProductItem(
                        id: productsData.items[index].id,
                        title: productsData.items[index].title,
                        imageUrl: productsData.items[index].imageUrl
                    ),
                    Divider()
                  ],
                ),
                itemCount: productsData.items.length,
              ),
            ),
          ),
        ),
      )
    );
  }
}
