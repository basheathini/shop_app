import 'package:flutter/material.dart';
class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      //key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 48,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "Building Number"),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 8,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "Street Name"),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 8,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "Surburb"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "City"),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 8,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "Postal Code"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8,),
            TextFormField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(labelText: "Country"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 25,),
            Container(
              height: 43,
              width: deviceSize.width * 0.99,
              child: RaisedButton(
                child:
                Text('CREATE ACCOUNT'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/products-overview');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                    color: Colors.black,
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
              ),
            ),
            FlatButton(
              child: Text('Back'),
              onPressed: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
