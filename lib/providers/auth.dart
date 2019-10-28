import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';

class Auth with ChangeNotifier{

  String _token;
  String _expiryDate;
  String _userId;

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
    final url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAmhVjalO2Yb5Z8kPoEcUkd51bb4Q-KMGY";
    try{

      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final responseData = json.decode(response.body);
      if(responseData['error'] !=  null){
        throw HttpExceptions(responseData['error']['message']);
      }

    }catch(error){
      throw error;

    }

//    print(response.body);

  }
}