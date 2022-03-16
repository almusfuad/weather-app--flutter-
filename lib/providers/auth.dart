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

  Future<void> login(String userName, String password) async {
    // using http instead of https to avoid erro cc:369
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
        "Access-Control_Allow_Origin": "*"
      },
    );

    final responseData = json.decode(responseLogin.body);

    // if (responseLogin.statusCode == 200) {
    //   print(responseData);
    // } else if (responseLogin.statusCode == 400) {
    //   print(responseData);
    // }

    print(responseLogin.statusCode);

    print(responseData.non_field_errors);
  }
}
