import 'package:flutter/material.dart';
class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){

          },)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: null,
          itemCount: 1,
        ),
      ),

    );
  }
}
