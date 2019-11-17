import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class AdaptiveButton extends StatefulWidget {

  final String text;
  final Function handler;
  final bool isLoading;
  AdaptiveButton(this.text, this.handler, this.isLoading);

  @override
  _AdaptiveButtonState createState() => _AdaptiveButtonState();
}

class _AdaptiveButtonState extends State<AdaptiveButton> {


  @override
  Widget build(BuildContext context) {
    return kIsWeb ? RaisedButton(
      child: widget.isLoading ? Text(widget.text, style: TextStyle(fontSize: 12),) : Text(widget.text, style: TextStyle(fontSize: 12),),
      onPressed: widget.handler,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding:
      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                    color: Colors.black,
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).primaryTextTheme.button.color,
    ) : (Platform.isIOS ? CupertinoButton(
      child: widget.isLoading ? Text(widget.text, style: TextStyle(fontSize: 12),) : Text(widget.text, style: TextStyle(fontSize: 12),),
      onPressed: widget.handler,
      color: Theme.of(context).accentColor,
    ) : RaisedButton(
      child: widget.isLoading ? Text(widget.text, style: TextStyle(fontSize: 12),) : Text(widget.text, style: TextStyle(fontSize: 12),),
      onPressed: widget.handler,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding:
      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                    color: Colors.black,
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).primaryTextTheme.button.color,
    ));
  }
}
