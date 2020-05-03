import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'd73bb9babdb11e3f869ad1817bd02729';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;

  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  void getLocationData() async {
    Location location = new Location();

    await location.getCurrentLocation();

    lat = location.latitude;
    long = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 30,
        )
      ),
    );
  }
}
