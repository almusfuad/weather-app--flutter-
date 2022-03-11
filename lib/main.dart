// material packages to show design
import 'package:flutter/material.dart';

// other packages
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/auth.dart';

// different screen data to load
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './models/routes.dart';
import './screens/signup_screen.dart';

void main() => runApp(WeatherApp());

// stateless widget so that the page can not change continuously
class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          MyRoutes.homeScreen: (context) => HomeScreen(),
          MyRoutes.loginScreen: (context) => LoginScreen(),
          MyRoutes.signupScreen: (context) => SignUp(),
        },
      ),
    );
  }
}
