import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  //named arguments
  Product({@required this.id, @required this.title, @required this.description, @required this.price, @required this.imageUrl, this.isFavorite = false});

  void _setFavorite(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> isProductFavorite() async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = "https://shopping-app-flutter-36ebb.firebaseio.com/products/$id.json";
    try{
      final response = await http.patch(url, body: json.encode({
      'isFavorite': isFavorite
      }));
      if(response.statusCode >= 400){
        _setFavorite(oldStatus);
      }
    }catch(error){
      _setFavorite(oldStatus);
    }
  }
}