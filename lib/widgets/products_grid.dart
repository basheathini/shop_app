import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(products[index].id, products[index].title, products[index].imageUrl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10

      ),
    );
  }
}
