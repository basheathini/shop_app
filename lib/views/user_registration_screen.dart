import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../widgets/adpative_button.dart';
class UserPersonalDetails extends StatefulWidget {
  static const routeName = '/user-registration';
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {
  bool isPersonal = true;


//  Future<void> _launchCamera() async{
//
//    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);
//
//    if(imageFile == null){
//      return;
//    }
//
////    setState(() {
////      _storeImage = imageFile;
////    });
//
////    final imageName = path.basename(imageFile.path);
////    final appDir = await sys_paths.getApplicationDocumentsDirectory();
////    final savedImagePlace = await imageFile.copy('${appDir.path}/$imageName');
////    widget.onSelectImage(savedImagePlace);
//
//  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final heightNeed = deviceSize.height - ((deviceSize.height / 100) * 35);

    return Scaffold(
      body: Container(
//      appBar: AppBar(title: Text('Sign Up'),),
        child: Stack(
          children: <Widget>[
            !kIsWeb ? Container(
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
            ): Container(),
            Center(
              child: !kIsWeb ? Card(
                margin: EdgeInsets.only(top: 70, bottom: 40),
                elevation: 2.0,
//              color: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child : AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    constraints: BoxConstraints(
                      minHeight: heightNeed
                  ),
                  //BoxConstraints(minHeight: _heightAnimation.value.height),
                  width: deviceSize.width * 0.80,
                  padding: EdgeInsets.only(top: 16, left: 20, right: 20),
//                padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        isPersonal ?
                        Form(
                        //key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 40,),
                              Image(image: AssetImage('assets/images/log.png'),fit: BoxFit.fill,width: 70,height: 70,),
                              SizedBox(height: 45,),
                              TextFormField(
                                decoration: InputDecoration(labelText: "First Name"),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 8,),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Last Name"),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 8,),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Contact Number"),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 8,),
                              TextFormField(
                                decoration: InputDecoration(labelText: "Email Address"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 43,
                                width: deviceSize.width * 0.99,
                                child: AdaptiveButton('Next',(){
                                  setState(() {
                                    isPersonal = false;
                                  });
                                }, isPersonal),
                              ),
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text("Already have an account? Login.", style: TextStyle(fontSize: 13),),
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),

                      ) :
                      Form(
                        //key: _formKey,

                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Image(image: AssetImage('assets/images/log.png'),fit: BoxFit.fill,width: 70,height: 70,),
                              SizedBox(height: 20,),
                              TextFormField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(labelText: "Building Number"),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(labelText: "Street Name"),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(labelText: "Surburb"),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 5,),
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
                              SizedBox(height: 5),
                              TextFormField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(labelText: "Country"),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 43,
                                width: deviceSize.width * 0.99,
                                child: AdaptiveButton('CREATE ACCOUNT',(){},isPersonal),
                              ),
                              FlatButton(
                                child: Text('Back'),
                                onPressed: (){
                                  setState(() {
                                    isPersonal = true;
                                  });
                                },
                              )
                            ],
                          ),

                      ),
                    ],
                  ),
                ),
                ),
              ) : Container(
                  child: SingleChildScrollView(
                    child : AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        constraints: BoxConstraints(
                            minHeight: heightNeed
                        ),
                        //BoxConstraints(minHeight: _heightAnimation.value.height),
                        width: deviceSize.width * 0.65,
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      //                padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Form(child: Column(
                            children: <Widget>[
                              Image(image: AssetImage('assets/images/log.png'),fit: BoxFit.fill,width: 70,height: 70,),
                              SizedBox(height: 20,),
                              Text('PERSONAL INFORMATION', textAlign: TextAlign.end,),
                              SizedBox(height: 20,),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:      TextFormField(
                                      decoration: InputDecoration(labelText: "First Name"),
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(child:      TextFormField(
                                    decoration: InputDecoration(labelText: "Last Name"),
                                    keyboardType: TextInputType.text,
                                  ),)

                                ]
                              ),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:      TextFormField(
                                        decoration: InputDecoration(labelText: "Phone Number"),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(child:      TextFormField(
                                      decoration: InputDecoration(labelText: "Email Address"),
                                      keyboardType: TextInputType.text,
                                    ),)

                                  ]
                              ),
                              SizedBox(height: 20,),
                              Text('ADDITIONAL INFORMATION'),

                              SizedBox(height: 20,),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:      TextFormField(
                                        decoration: InputDecoration(labelText: "Building Number"),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(child:      TextFormField(
                                      decoration: InputDecoration(labelText: "Street Name"),
                                      keyboardType: TextInputType.text,
                                    ),)

                                  ]
                              ),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:      TextFormField(
                                        decoration: InputDecoration(labelText: "Surburb"),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(child:      TextFormField(
                                      decoration: InputDecoration(labelText: "Email Address"),
                                      keyboardType: TextInputType.text,
                                    ),)

                                  ]
                              ),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:      TextFormField(
                                        decoration: InputDecoration(labelText: "City "),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(child:      TextFormField(
                                      decoration: InputDecoration(labelText: "Postal Code"),
                                      keyboardType: TextInputType.text,
                                    ),)

                                  ]
                              ),
                              SizedBox(width: 20,),
                              Row(
                                children: <Widget>[
                                  Expanded(child:      TextFormField(
                                    decoration: InputDecoration(labelText: "Country"),
                                    keyboardType: TextInputType.text,
                                  ),),


                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Checkbox(activeColor: Colors.black,value: false, ),
                                  ),
                                  Expanded(
                                    child: Text('By clicking the checkbox you agreed to the terms and conditions'),
                                  ),

                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('Alread have an account? Sign In'),
                                  ),
                                  Expanded(
                                    child: RaisedButton(
                                      color: Theme.of(context).accentColor,
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('CREATE ACCOUNT', style: TextStyle(color: Colors.white),),
                                    ),
                                  ),

                                ],
                              )
//                              Container(
//                                width: deviceSize.width * 0.70,
//                                child: RaisedButton(
//                                  color: Theme.of(context).accentColor,
//                                  onPressed: (){},
//                                  child: Text('CREATE ACCOUNT', style: TextStyle(color: Colors.white),),
//                                ),
//                              )

                            ],
                          ),)

                        ],
                      )
                    ),
            ),
        ),
      ),
      ]
      ),
      ),
    );
  }
}

class NewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

