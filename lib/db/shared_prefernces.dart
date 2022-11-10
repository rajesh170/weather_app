import 'package:flutter/src/widgets/editable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePref {
  static SharedPreferences? _preferences;

  // setToken(String token) async {
  //   final pass = await SharedPreferences.getInstance();
  //   pass.setString('token', token);
  // }

  // Future<String> getToken() async {
  //   final pass = await SharedPreferences.getInstance();
  //   String token = pass.getString('token')!;
  //   return token;
  // }

  setTemperature(double temperature) async {
    final sharePref = await SharedPreferences.getInstance();
    sharePref.setDouble("temperature", temperature);
  }

  Future<double> getTemperature() async {
    final temp = await SharedPreferences.getInstance();
    double tempVal = temp.getDouble("temperature") ?? 0;
    return tempVal;
  }

  setCityName(String cityName) async {
    final sharePref = await SharedPreferences.getInstance();
    sharePref.setString("city", cityName);
  }

  Future<String> getCityName() async {
    final sharedPref = await SharedPreferences.getInstance();
    String cityName = sharedPref.getString("city") ?? "";
    print(cityName);
    return cityName;
  }

  setIsWelcomed(bool isWelcomed) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("firstTime", isWelcomed);
  }

  getIsWelcomed() async {
    final sharedPref = await SharedPreferences.getInstance();
    bool welcomed = sharedPref.getBool("firstTime") ?? false;

    return welcomed;
  }

  setCondTextAndIcon(String text, String icon) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('text', text);
    sharedPref.setString('icon', icon);
  }

  getCondText() async {
    final sharedPref = await SharedPreferences.getInstance();
    String text = sharedPref.getString('text') ?? "Windy";
    return text;
  }

  getCondIcon() async {
    final sharedPref = await SharedPreferences.getInstance();

    String icon = sharedPref.getString("icon") ?? "https://cdn.weatherapi.com/weather/64x64/night/113.png";
    return icon;
  }
}
