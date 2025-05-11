import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AuthServices extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBTsm2huXt545Kt_GxxGcQqkdylMLJDKWw';

  Future<String?> login(String email, String pasword) async{
    print('auth data');
    final Map<String, dynamic> authData = {
      'email': email,
      'password': pasword
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    print(authData);
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse.containsKey('idToken')) {
      print('login Ok');

      return null;
    } else {
      return decodedResponse['error']['message'];
    }
  }


  Future<String?> create_user(String email, String pasword) async{
    print('cereate user');
    final Map<String, dynamic> authData = {
      'email': email,
      'password': pasword
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    print(authData);
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    print('decoded response');
    print(decodedResponse);
    if (decodedResponse.containsKey('idToken')) {
      print('create user Ok');
      return null;
    } else {
      print('decodedResponse');
      print(decodedResponse);
      return decodedResponse['error']['message'];
    }
  }
}