// core packages
import 'dart:convert';

// material package to show design
import 'package:flutter/material.dart';

// other packages to help
import 'package:http/http.dart' as http;

// Stateful widget to show dynamic UI Screen
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temperature = 0;
  String location = 'Dhaka';
  int woeid = 2487956;
  String weather = 'clear';

// API url search
  final String searchApiUrl =
      'https://www.metaweather.com/api/location/search/?query=';

  final String searchApiLocation = 'https://www.metaweather.com/api/location/';

// function for searching result
  void fetchSearch(String input) async {
    // variable to search location String as iput
    var searchResult = await http.get(
      Uri.parse(searchApiUrl + input),
    );

    // variable to view the result
    var result = jsonDecode(searchResult.body)[0];

    // setstate to change result dynamically
    setState(() {
      location = result['title'];
      woeid = result['woeid'];
    });
  }

  // function for location result
  void fetchLocation() async {
    // searching for location
    var searchLocation = await http.get(
      Uri.parse(searchApiLocation + woeid.toString()),
    );
    var result = jsonDecode(searchLocation.body);
    var consolidated_weather = result['consolidated_weather'];
    var data = consolidated_weather[0];

    // to see dynamically loaded data
    setState(() {
      temperature = data['the_temp'].round();
      weather = data['weather_state_name'].replaceAll(' ', '').toLowerCase();
    });
  }

  // calling function while textFieldSubmitter
  void onTextFieldSubmitted(String input) {
    fetchSearch(input);
    fetchLocation();
  }

// widget working tree
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/$weather.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    temperature.toString() + ' °C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    onSubmitted: (String input) {
                      onTextFieldSubmitted(input);
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search another Location',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
