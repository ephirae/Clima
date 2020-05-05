import 'dart:io';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  var weatherData;

  WeatherModel weather = WeatherModel();

  Future<bool> checkCityName(var cityName) async {
    weatherData = await Future.any([
      weather.getCityWeather(cityName, context),
      Future.delayed(const Duration(seconds: 5))
    ]);
    if (weatherData == null && weatherData != SocketException('error')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text("Invalid city name. Check your spelling?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("TRY AGAIN"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (await checkCityName(cityName)) {
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
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
