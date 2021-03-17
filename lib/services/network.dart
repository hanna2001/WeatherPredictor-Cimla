import 'package:http/http.dart';
import 'dart:convert';

class Networking {
  String url;
  Networking({this.url});
  Future getData() async {
    Response r = await get(url);

    if (r.statusCode == 200) {
      String data = r.body;
      return jsonDecode(data);
    } else
      print(r.statusCode);
  }
}
