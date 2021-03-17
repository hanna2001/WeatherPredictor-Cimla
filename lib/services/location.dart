import 'package:geolocator/geolocator.dart';


class Location {
  double latitude;
  double longitude;

  Future<void> getLocation() async {
    try {
      Position p = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = p.latitude;
      longitude = p.longitude;
    } catch (e) {
      print(e);
    }
  }
}
// Response r = await get(
// 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=$apiId');
//
// if (r.statusCode == 200) {
// //print(r.body);
// String data = r.body;
