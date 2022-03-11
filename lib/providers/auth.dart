import 'dart:convert';

// package to render material app
import 'package:flutter/material.dart';

// other packages
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  // String _userName;
  // String _password;

  Future<String> signup(String email, String userName, String password) async {
    final url = Uri.parse('http://fluttertest.accelx.net/auth/users/');

    final response = await http.post(
      url,
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

    return json.decode(response.body);
  }

  Future<String> login(String userName, String password) {}
}
