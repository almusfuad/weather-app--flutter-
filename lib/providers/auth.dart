// core dart packages
import 'dart:convert';

// package to render material app
import 'package:flutter/material.dart';

// other packages
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  // String _userName;
  // String _password;

  Future signup(String email, String userName, String password) async {
    final signUpUrl =
        await Uri.parse('http://fluttertest.accelx.net/auth/users/');

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
      },
    );

    print(json.decode(responseSent.body));
  }

  Future login(String userName, String password) async {
    // using http instead of https to avoid erro cc:369
    final loginUrl = await Uri.parse(
      'http://fluttertest.accelx.net/auth/token/login',
    );

    final responseLogin = await http.post(
      loginUrl,
      body: json.encode(
        {
          "username": userName,
          "password": password,
        },
      ),
      headers: <String, String>{
        "Content-Type": 'application/json',
        'Accept': 'application/json',
        // // "Vary": 'Accept',
        "Access-Control-Allow-Origin": "*",
        // "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type"
      },
    );

    final responseData = await json.decode(responseLogin.body);

    print(responseLogin.statusCode);

    // print(responseData.non_field_errors);
  }
}
