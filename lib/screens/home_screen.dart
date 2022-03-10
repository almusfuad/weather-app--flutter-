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
  // variable to load data
  int temperature;
  String location = 'Dhaka';
  int woeid = 1915035;
  String weather = 'clear';
  String abbreviation = '';
  String errorMessage = '';

// API url search
  final String searchApiUrl =
      'https://www.metaweather.com/api/location/search/?query=';

  final String searchApiLocation = 'https://www.metaweather.com/api/location/';

  // initial stage screen
  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

// function for searching result
  void fetchSearch(String input) async {
    try {
      // variable to search location String as input
      var searchResult = await http.get(
        Uri.parse(searchApiUrl + input),
      );

      // variable to view the result
      var result = await jsonDecode(searchResult.body)[0];

      // setstate to change result dynamically
      setState(() {
        location = result['title'];
        woeid = result['woeid'];
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        errorMessage =
            "Sorry, we don't have the city in our database. Please search another city.";
      });
    }
  }

  // function for location result
  void fetchLocation() async {
    // searching for location
    var searchLocation = await http.get(
      Uri.parse(searchApiLocation + woeid.toString()),
    );
    var result = await jsonDecode(searchLocation.body);
    var consolidated_weather = await result['consolidated_weather'];
    var data = await consolidated_weather[0];

    // to see dynamically loaded data
    setState(() {
      temperature = data['the_temp'].round();
      weather = data['weather_state_name'].replaceAll(' ', '').toLowerCase();
      abbreviation = data['weather_state_abbr'];
    });
  }

  // calling function while textFieldSubmitter
  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    await fetchLocation();
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
      child: temperature == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      abbreviation == ''
                          ? SizedBox()
                          : Center(
                              child: Image.network(
                                'https://www.metaweather.com/static/img/weather/png/' +
                                    abbreviation +
                                    '.png',
                                width: 100,
                              ),
                            ),
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
                      ),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
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
