import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';


class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });

}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cartProducts, double total) async{
    print(userId);
    final url = "https://shopping-app-flutter-36ebb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timestamp = DateTime.now();
    
    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': timestamp.toIso8601String(),
      'products' : cartProducts.map((cp) => {
        'id': cp.id,
        'title': cp.title,
        'quantity': cp.quantity,
        'price': cp.price
      })
    .toList(),
    }));

    _orders.insert(0, OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp));
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final url = "https://shopping-app-flutter-36ebb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final response = await http.get(url);
    //print(json.decode(response.body));

    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null){
      return;
    }
    
    extractedData.forEach((keyIds, valuesOrderData) {
      loadedOrders.add(OrderItem(id: keyIds,
          amount: valuesOrderData['amount'],
          dateTime: DateTime.parse(valuesOrderData['dateTime']),
          products: (valuesOrderData['products'] as List<dynamic>)
              .map((item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title']
          )
          ).toList(),

      )
      );

    });
    print(loadedOrders);
    _orders = loadedOrders.reversed.toList();
    notifyListeners();

  }
}