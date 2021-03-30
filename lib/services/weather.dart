import 'package:cimla/services/location.dart';
import 'package:cimla/services/network.dart';

String apiId = '109a931e40c286b677c79b850dfea4ce';
String basicURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityLocation(String cityName) async {
    Networking networking =
        Networking(url: '$basicURL?q=$cityName&appid=$apiId&units=metric');
    var data = await networking.getData();
    return data;
  }

  Future<dynamic> getLocationWeather() async {
    Location l = Location();
    await l.getLocation();
    Networking network = Networking(
        url:
            '$basicURL?lat=${l.latitude}&lon=${l.longitude}&appid=$apiId&units=metric');
    var data = await network.getData();
    return data;
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
