import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';

const apiKey = 'd73bb9babdb11e3f869ad1817bd02729';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName, BuildContext context) async {
    try {
      var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';

      NetworkHelper networkHelper = NetworkHelper(url);

      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (SocketException) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: new Text("No internet connection detected."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("EXIT"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return SocketException();
    }
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = new Location();
      await location.getCurrentLocation();

      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (SocketException) {
      print('no internet connection detected');
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
