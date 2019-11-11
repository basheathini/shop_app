import 'package:flutter/material.dart';
class UserPersonalDetails extends StatefulWidget {
  static const routeName = '/user-registration';
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Information'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(

          )

        ],
      ),

    );
  }
}
