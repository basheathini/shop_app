import 'package:flutter/material.dart';
import '../views/user_registration_screen.dart';
import '../widgets/contact_details.dart';
class PersonalInformation extends StatefulWidget {
  static const routeName = '/personal-details';
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      //key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70,),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey,
              child: Icon(Icons.add_a_photo),
//              backgroundImage: NetworkImage("https://static.highsnobiety.com/thumbor/mbuWl_RZV7yv3Hlj3Skwg8dREM8=/fit-in/1200x800/smart/static.highsnobiety.com/wp-content/uploads/2018/02/12134547/lil-wayne-tha-carter-v-01.jpg"),

            ),
            SizedBox(height: 48,),
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
            SizedBox(height: 25,),
            Container(
              height: 43,
              width: deviceSize.width * 0.99,
              child: RaisedButton(
                child:
                Text('Next', style: TextStyle(fontSize: 12),),
                onPressed: () {

//                  UserPersonalDetails(false);
                  Navigator.of(context).pushNamed(ContactDetails.routeName);
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
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Already have an account? Login.", style: TextStyle(fontSize: 13),),
            )
          ],
        ),
      ),
    );
  }
}
