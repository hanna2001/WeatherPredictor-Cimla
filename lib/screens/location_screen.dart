import 'package:cimla/screens/city_screen.dart';
import 'package:cimla/services/weather.dart';
import 'package:cimla/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final data;
  LocationScreen({this.data});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temp;
  String icon;
  String cityName;
  String mess;
  WeatherModel model = WeatherModel();
  @override
  void initState() {
    super.initState();
    getNewValues(widget.data);
  }

  void getNewValues(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        icon = 'Error';
        temp = 0;
        mess = '';
        return;
      }
      icon = model.getWeatherIcon(weatherData['weather'][0]['id']);
      temp = weatherData['main']['temp'];
      cityName = weatherData['name'];
      mess = '${model.getMessage(temp.toInt())} in $cityName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/location_pg_background.jpg'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () async {
                      var data = await model.getLocationWeather();
                      getNewValues(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: k_iconSize,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      print(cityName);
                      var data = await model.getCityLocation(cityName);
                      getNewValues(data);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(k_padding),
                child: Row(
                  children: [
                    Text(
                      '$temp°',
                      style: k_tempTextStyle,
                    ),
                    Text(
                      icon,
                      style: k_tempTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: k_padding),
                child: Text(
                  mess,
                  textAlign: TextAlign.right,
                  style: k_mesTextStyle,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
