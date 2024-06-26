import 'package:flutter/material.dart';

// other packages
import 'package:provider/provider.dart';

// other files
import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _loginData = {
    "username": '',
    "password": '',
  };

  // username validation
  String usernameValid(String value) {
    if (value.isEmpty) {
      return 'Please input your username.';
    } else {
      return null;
    }
  }

  // password validation
  String passwordValid(String value) {
    if (value.isEmpty) {
      return 'Please input your password.';
    } else {
      return null;
    }
  }

  Future _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await Provider.of<Auth>(context, listen: false).login(
        _loginData["username"],
        _loginData["password"],
      );
      setState(() {
        Navigator.pushNamed(context, '/homeScreen');
      });
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credential error. Please try agian.'),
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
            'assets/auth/login.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 40,
                top: 100,
              ),
              child: Text(
                'Please login\nto continue',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
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
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _usernameController,
                        validator: usernameValid,
                        onSaved: (value) {
                          _loginData["username"] = value;
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
                        controller: _passwordController,
                        validator: passwordValid,
                        onSaved: (value) {
                          _loginData["password"] = value;
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign In',
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
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signupScreen');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff4c505b),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password?',
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
