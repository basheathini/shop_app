import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;


  @override
  void initState() {
//    Future.delayed(Duration.zero).then((_) async{
//      setState(() {
        _isLoading = true;
//      });

      Provider.of<Orders>(context, listen: false).fetchOrders().then((_){
        setState(() {
          _isLoading = false;
        });
      });


//    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center( child: CircularProgressIndicator()) : ListView.builder(
        itemBuilder: (context, index) =>
            OrderItem(order: orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
