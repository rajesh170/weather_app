import 'package:weather_app/networks/network_base.dart';

class NetworkCalls {
  NetworkBase networkBase = NetworkBase();

  getWeatherByCity(String city) async {
    var response = await networkBase.get(
        "current.json?key=c4cbd17b9e6f4e59b38141921220711&q=$city",
        needToken: false);

    return response;
  }

  getWeatherByGeoCod(String lat,String long) async{
    var response = await networkBase.get(
        "current.json?key=c4cbd17b9e6f4e59b38141921220711&q=$lat,$long",
        needToken: false);
    return response;
  }
}
