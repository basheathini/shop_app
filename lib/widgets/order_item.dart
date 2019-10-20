import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../providers/orders.dart' as ord;
class OrderItem extends StatefulWidget   {
  final ord.OrderItem order;

  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();

}

class _OrderItemState extends State<OrderItem>{

  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('R${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yy hh:mm').format(widget.order.dateTime)
            ),
            trailing: IconButton(
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          ),
          ),
          if(_expanded)(
            Container(
              margin: EdgeInsets.all(15),
              height: min(widget.order.products.length * 20.0 + 20, 180),
              child: ListView(
                children: widget.order.products.map((prod) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                  Text(prod.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('${prod.quantity}x R${prod.price}', style: TextStyle(fontSize: 18, color: Colors.grey),)
                ],)).toList(),

              ),
            )
          )
        ],
      ),
    );
  }
}