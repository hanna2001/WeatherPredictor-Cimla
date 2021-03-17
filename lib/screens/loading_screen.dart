import 'package:cimla/screens/location_screen.dart';
import 'package:cimla/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    var data = await WeatherModel().getLocationWeather();
    //print(data);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white),
      ),
    );
  }
}
