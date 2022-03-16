// package to show material design
import 'dart:ffi';

import 'package:flutter/material.dart';

// extra packages
import 'package:provider/provider.dart';

// external file to use in this file
import '../providers/auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map _registrationData = {
    "email": '',
    "username": '',
    "password": '',
  };

  // array for email and username
  final emailArr = [];
  final userNameArr = [];

  // validation rules for email
  String validEmail(String value) {
    if (value.isEmpty) {
      return 'An email is required';
    } else if (!value.contains('@')) {
      return 'Please enter a valid password';
    } else if (emailArr.contains(value) != -1) {
      return 'This email is already registered.';
    } else {
      return null;
    }
  }

  // validation rules of username
  String validUserName(String value) {
    if (value.isEmpty) {
      return 'User name cannot be a null';
    } else if (userNameArr.contains(value) != -1) {
      return 'The username is already registered.';
    } else {
      return null;
    }
  }

  // validation rules of getting password
  String validPass(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = new RegExp(pattern);

    if (value.isEmpty) {
      return 'Please enter a password';
    } else if (!regExp.hasMatch(value)) {
      return 'Your password must contain Uppercase, Lowercase, Numeric, Special character and must be at least 8 characters.';
    } else if (value.toLowerCase().contains('password')) {
      return 'You cannot use a common password';
    } else {
      return null;
    }
  }

// submitting the values to registration
  Future _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await Provider.of<Auth>(context, listen: false).signup(
        _registrationData["email"],
        _registrationData["username"],
        _registrationData["password"],
      );

      setState(() {
        Navigator.pushNamed(context, '/loginScreen');
      });
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Try again'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/auth/register.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 40,
                top: 130,
              ),
              child: Text(
                'Welcome to\nweather app',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 35,
                  right: 35,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _email,
                        validator: validEmail,
                        onSaved: (value) {
                          _registrationData["email"] = value;

                          emailArr.add(value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _userName,
                        validator: validUserName,
                        onSaved: (value) {
                          _registrationData["username"] = value;

                          userNameArr.add(value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _password,
                        validator: validPass,
                        onSaved: (value) {
                          _registrationData["password"] = value;
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4c505b),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: _submit,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginScreen');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff4c505b),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
