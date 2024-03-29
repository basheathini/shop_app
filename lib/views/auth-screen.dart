
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exceptions.dart';
import '../views/user_registration_screen.dart';
import '../widgets/adpative_button.dart';
import 'package:flutter/foundation.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return kIsWeb ? Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ) :
    Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/perfect.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center
              ),
//              color: Colors.white,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 69, 0, 1).withOpacity(0.9),
                  Color.fromRGBO(255, 140, 0, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  var _doingState = 'SIGN IN';
  final _passwordController = TextEditingController();
  //flutter animations
  AnimationController _controller;
//  Animation<Size> _heightAnimation;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  initState(){
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);
    _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0,0)).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
//    _heightAnimation = Tween<Size>(begin: Size(double.infinity, 260), end: Size(double.infinity, 320)).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    //_heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  Future<void> _submit() async {
    print(_formKey);
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
      _doingState = 'AUTHENTICATING...';
    });

    try{
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    }on HttpExceptions catch(error){

      var errorMessage = 'Authenication failed';

      if(error.toString().contains('EMAIL_EXISTS')){
        errorMessage = 'This email address is already in use';
      } else if(error.toString().contains('INVALID_EMAIL')){
        errorMessage = 'This not a valid email address';
      }else if (error.toString().contains('WEAK_PASSWORD')){
        errorMessage = 'This password is too weak';
      }else if(error.toString().contains('EMAIL_NOT_FOUND')){
        errorMessage = 'Could not find a user with that email';
      }else if(error.toString().contains('INVALID_PASSWORD')){
        errorMessage = 'Invalid password';
      }

      _showErrorDialog(errorMessage);

    }catch (error){
      var errorMessage = 'Could not authenticate you.';
      _showErrorDialog(errorMessage);
    }


    setState(() {
      _isLoading = false;
      _doingState = 'SIGN IN';
    });
  }

  void _showErrorDialog(String message){
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('An error occurred'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(child: Text('Okay'), onPressed: () {
          Navigator.of(ctx).pop();
        },)
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 1.0,
      //animatedContainer does not need to configure controller and animation
      child:  AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 300 : 200),
//        width: deviceSize.width * 0.80,
        width: kIsWeb? 500 : deviceSize.width * 0.80,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(labelText: 'Username',icon: Icon(Icons.person)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid username!';
                      }
                      },
                    onSaved: (value) {
                      _authData['email'] = 'bashe.athini@gmail.com';
                      },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password',icon: Icon(Icons.lock),),
                  style: TextStyle(fontSize: 15),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    },
                  onSaved: (value) {
                  _authData['password'] = '0839954149Bash';
                  },
                ),
                SizedBox(height: 15,),
                Container(
                  height: 43,
                  width: deviceSize.width * 0.99,
                  child: AdaptiveButton(_doingState,_submit,_isLoading)
                ),
                SizedBox(height: 5,),
                FlatButton(
                  child: Text('Don\'t have an account ? Sign Up.',
                  style: TextStyle(fontSize: 13, color: Colors.black,),),
                  onPressed: (){
                    Navigator.of(context).pushNamed(UserPersonalDetails.routeName);
                  },
              )
            ],
          ),
        ),
      ),),
    );
  }
}
