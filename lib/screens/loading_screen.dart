import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'city_screen.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    WeatherModel weatherModel = WeatherModel();

    //handle timeout
    try {
      var weatherData = await Future.any([
        weatherModel.getLocationWeather(),
        Future.delayed(const Duration(seconds: 5))
      ]);

      if (weatherData == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CityScreen();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LocationScreen(
                locationWeather: weatherData,
              );
            },
          ),
        );
      }
    } catch (SocketException) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitPulse(
        color: Colors.white,
        size: 100,
      )),
    );
  }
}
