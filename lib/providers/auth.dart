import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exceptions.dart';


class Auth with ChangeNotifier{

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  String get token {
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null ){
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async{
    return _authenticate(email, password, 'signUp');
//    const url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAmhVjalO2Yb5Z8kPoEcUkd51bb4Q-KMGY";
//    final response = await http.post(url, body: json.encode({
//      'email': email,
//      'password': password,
//      'returnSecureToken': true,
//    }));
//    print(response.body);
  }

  Future<void> login(String email, String password) async{
    return _authenticate(email, password, 'signInWithPassword');
//    const url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAmhVjalO2Yb5Z8kPoEcUkd51bb4Q-KMGY";
//    final response = await http.post(url, body: json.encode({
//      'email': email,
//      'password': password,
//      'returnSecureToken': true,
//    }));
//    print(response.body);
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async{
    final url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAYqzxLq4vA387KgOniRU5Y4uRXJQ9Fykg";
    try{

      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final responseData = json.decode(response.body);
      print(responseData);
      if(responseData['error'] !=  null){
        throw HttpExceptions(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();

      final preferences = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token' : _token,
        'userId' : _userId,
        'expiryData' : _expiryDate.toIso8601String()
      });

      preferences.setString('userData', userData);

    }catch(error){
      throw error;

    }
//    print(response.body);
  }

  Future<bool> autoLogin() async {
    final preferences = await SharedPreferences.getInstance();

    if(!preferences.containsKey('userData')){
      return false;
    }

    final extractedUserData = json.decode(preferences.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = extractedUserData['expiryData'];

    notifyListeners();

    return true;
  }

  Future<void> signOut() async{
    _userId = null;
    _expiryDate = null;
    _token = null;

    if(_authTimer != null){
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    //pref.remove('userData');
    pref.clear();

  }

  void _autoLogout(){
    if(_authTimer != null){
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), signOut);
  }
}