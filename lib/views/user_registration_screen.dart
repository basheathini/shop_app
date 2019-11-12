import 'package:flutter/material.dart';
class UserPersonalDetails extends StatefulWidget {
  static const routeName = '/user-registration';
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final heightNeed = deviceSize.height - ((deviceSize.height / 100) * 30);
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 69, 0, 1),
                  Color.fromRGBO(255, 255, 255, 1),
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
                width: deviceSize.width * 0.78,
                padding: EdgeInsets.all(16.0),
                child: Form(
//                key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 35,),
                        CircleAvatar(radius: 63,backgroundColor: Theme.of(context).primaryColor, backgroundImage: NetworkImage(""),),
                        SizedBox(height: 48,),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Athini"),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Bashe"),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 9,),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(labelText: "South Africa, Western Cape, Cape Town"),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 25,),
                        FlatButton(
                          child: Text("Next", style: TextStyle(fontSize: 14),),
                        )
                      ],
                    ),
                  ),
                ),),
            ),
          )
        ],
      )

    );
  }
}
