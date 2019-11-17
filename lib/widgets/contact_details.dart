import 'package:flutter/material.dart';
class ContactDetails extends StatefulWidget {
  static const routeName = '/contact-details';
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final heightNeed = deviceSize.height - ((deviceSize.height / 100) * 15);
    return Container(
//      appBar: AppBar(title: Text('Sign Up'),),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 69, 0, 1),
                    Color.fromRGBO(255, 140, 0, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
            ),
            Center(
              child: Card(
                elevation: 5.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  constraints: BoxConstraints(
                      minHeight: heightNeed
                  ),
                  //BoxConstraints(minHeight: _heightAnimation.value.height),
                  width: deviceSize.width * 0.80,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
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
                                borderRadius: BorderRadius.circular(10),
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
                              Navigator.of(context).pushReplacementNamed('/user-registration');
//                UserPersonalDetails(true);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )

    );
  }
}
