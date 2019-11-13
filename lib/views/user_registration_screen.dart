import 'package:flutter/material.dart';
import '../widgets/personal_information.dart';
import '../widgets/contact_details.dart';
class UserPersonalDetails extends StatefulWidget {
  static const routeName = '/user-registration';
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {

  bool isPersonal = true;

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
                width: deviceSize.width * 0.90,
                padding: EdgeInsets.all(16.0),
                child: isPersonal ? PersonalInformation() : ContactDetails(),
              ),
            ),
          )
        ],
      )

    );
  }
}
