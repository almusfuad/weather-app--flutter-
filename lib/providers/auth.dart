// core dart packages
import 'dart:convert';
import 'dart:io';

// package to render material app
import 'package:flutter/material.dart';

// other packages
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  // String _userName;
  // String _password;

  Future<void> signup(String email, String userName, String password) async {
    final signUpUrl = Uri.parse('http://fluttertest.accelx.net/auth/users/');

    final responseSent = await http.post(
      signUpUrl,
      body: json.encode(
        {
          "email": email,
          "username": userName,
          "password": password,
        },
      ),
      headers: {
        "Content-Type": "application/json",
        "Vary": "Accept",
        "WWW-Authenticate": "Token",
      },
    );

    return responseSent.body;
  }

  Future<void> login(String userName, String password) async {
    final loginUrl = Uri.parse(
      'http://fluttertest.accelx.net/auth/token/login',
    );

    final responseLogin = await http.post(
      loginUrl,
      body: json.encode(
        {
          "password": password,
          "username": userName,
        },
      ),
      headers: {
        "Content-Type": "application/json",
        "Vary": "Accept",
      },
    );

    print(json.decode(responseLogin.body));
  }
}
