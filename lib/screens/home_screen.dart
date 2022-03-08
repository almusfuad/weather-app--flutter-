import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int temperature = 0;
  final String location = 'Dhaka';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/clear.png',
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
